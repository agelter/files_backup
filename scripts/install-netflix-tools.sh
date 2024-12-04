#!/usr/bin/env bash

# newt
curl -q -sL 'https://go.prod.netflix.net/newt-install' | bash

# metatron
curl -s 'https://artifacts.netflix.com/devtools/metatron-cli/install-script' | bash

# dropship
curl -sL https://go.prod.netflix.net/install-vscode-dropship | bash

# git-clang-format
# specific SHA because the most recent version of git-clang-format
# is not compatible with the version of clang-format (16.0.6) installed by nix
mkdir -p "${HOME}/bin"
curl -sL https://raw.githubusercontent.com/llvm/llvm-project/aeaae5311b8d4bbcfe7ef5cff722ea36b038c0ad/clang/tools/clang-format/git-clang-format \
    -o "${HOME}/bin/git-clang-format"
chmod +x "${HOME}/bin/git-clang-format"
