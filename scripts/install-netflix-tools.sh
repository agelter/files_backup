#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Error: run as '$0 <dotfiles-proj-root>'"
    exit 1
fi
DOTFILES_PROJ_ROOT="$1"

# newt
curl -q -sL 'https://go.prod.netflix.net/newt-install' | bash

# metatron for dedicated instance
sudo cp "${DOTFILES_PROJ_ROOT}/configs/nflx.list" /etc/apt/sources.list.d/nflx.list
if ! command -v metatron > /dev/null && [ ! -f "${DOTFILES_PROJ_ROOT}/root/metatron/decrypted/nflx-artifactory.asc" ]; then
    echo "Error: nflx-artifactory.asc not yet decrypted and metatron CLI is not installed."
    echo "You'll have to scp the file onto this machine to ${DOTFILES_PROJ_ROOT}/root/metatron/decrypted/nflx-artifactory.asc to bootstrap."
    echo "Then run this script again."
    exit 1
else
    sudo cp "${DOTFILES_PROJ_ROOT}/root/metatron/decrypted/nflx-artifactory.asc" /etc/apt/trusted.gpg.d/nflx-artifactory.asc
fi
sudo apt update && sudo apt install -y metatron-tools

# dropship
curl -sL https://go.prod.netflix.net/install-vscode-dropship | bash

# shelby-cli
curl https://file.dta.netflix.com/shelby/cli/install.sh | bash

# git-clang-format
# specific SHA because the most recent version of git-clang-format
# is not compatible with the version of clang-format (16.0.6) installed by nix
mkdir -p "${HOME}/bin"
curl -sL https://raw.githubusercontent.com/llvm/llvm-project/aeaae5311b8d4bbcfe7ef5cff722ea36b038c0ad/clang/tools/clang-format/git-clang-format \
    -o "${HOME}/bin/git-clang-format"
chmod +x "${HOME}/bin/git-clang-format"
