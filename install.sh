#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Error: run as '$0 <config>' where config is one of the configurations in flake.nix"
  exit 1
fi

CONFIG="$1"

# install nix
sh <(curl -L https://nixos.org/nix/install)

# enable flakes
mkdir -p "${HOME}/.config/nix/"
echo "experimental-features = nix-command flakes" > "${HOME}/.config/nix/nix.conf"

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install home-manager
#nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#nix-channel --update
#nix-shell '<home-manager>' -A install

# init!
nix run .#home-manager -- switch --flake .#${CONFIG}

# add shellcheck