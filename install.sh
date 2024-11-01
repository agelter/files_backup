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
  sh <(curl -L https://nixos.org/nix/install)

  # enable flakes
  mkdir -p "${HOME}/.config/nix/"
  echo "experimental-features = nix-command flakes" > "${HOME}/.config/nix/nix.conf"
else
  echo "Nix is already installed"
fi

# source nix
[ -f ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh

# init!
nix run .#home-manager -- switch --flake .#"${CONFIG}" -b bk

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"
