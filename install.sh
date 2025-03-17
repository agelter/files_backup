#!/usr/bin/env bash

set -eu

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"

if [ -z "$1" ]; then
  echo "Error: run as '$0 <config>' where config is one of the configurations in flake.nix"
  exit 1
fi

if [ -n "${3:-}" ]; then
  echo "Only one flag (--update or --clean) is allowed"
  exit 1
fi

CONFIG="$1"
FLAG="${2:-''}"

# hack because nix doesn't want to run scripts directly
# Run the newt installation script
if [ -f "$HOME/.install-netflix-tools.sh" ] && [ ! -f "$HOME/.netflix_tools_installed" ]; then
  "$HOME/.install-netflix-tools.sh" "$SCRIPT_DIR"
  touch "$HOME/.netflix_tools_installed"
fi

if command -v metatron > /dev/null; then
  # decrypt secrets
  metatron decrypt -a

  # hack: add secrets to git so nix can pick them up
  git add -f root/metatron/decrypted/
else
  echo "Metatron is not (yet) installed. Skipping decryption of secrets."
fi

cleanup() {
  if [ -d "${SCRIPT_DIR}/root/metatron/decrypted" ]; then
    cd "${SCRIPT_DIR}" || true
    git restore --staged --worktree root/metatron/decrypted/
  fi
}
trap cleanup EXIT SIGINT SIGTERM
# end hack

# install nix
if ! command -v nix > /dev/null; then
  echo "Installing nix..."
  if [[ "$(uname)" == "Darwin" ]]; then
    if [ -e /nix ] && [[ "$FLAG" == "--clean" ]]; then
      echo "Cleaning up old nix installation"
      zsh scripts/uninstall_nix_macos.zsh
    fi
    sh <(curl -L https://nixos.org/nix/install)
  elif [[ "$(uname)" == "Linux" ]]; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
  else
    echo "Unknown operating system."
    exit 1
  fi

  # enable flakes
  mkdir -p "${HOME}/.config/nix/"
  echo "experimental-features = nix-command flakes" > "${HOME}/.config/nix/nix.conf"

  echo "Launch a new shell and then re-run this script."
  exit 0
else
  echo "Nix is already installed"
fi

if ! command -v home-manager > /dev/null; then
  echo "Installing home-manager..."
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

# init!
if [[ "$FLAG" == "--update" ]]; then
    echo "Updating flake.lock with latest packages"
    nix flake update
fi
home-manager switch --flake .#"${CONFIG}" -b bk

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"

