#!/usr/bin/env bash

set -eu

if [ -z "$1" ]; then
  echo "Error: run as '$0 <config>' where config is one of the configurations in flake.nix"
  exit 1
fi

CONFIG="$1"

# install nix
if ! command -v nix > /dev/null; then
  echo "Installing nix..."
  if [[ "$(uname)" == "Darwin" ]]; then
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
else
  echo "Nix is already installed"
fi

# init!
home-manager switch --flake .#"${CONFIG}" -b bk

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"

# hack because nix doesn't want to run scripts directly
# Run the newt installation script
if [ -f "$HOME/.install-netflix-tools.sh" ] && [ ! -f "$HOME/.netflix_tools_installed" ]; then
  "$HOME/.install-netflix-tools.sh"
  touch "$HOME/.netflix_tools_installed"
fi
