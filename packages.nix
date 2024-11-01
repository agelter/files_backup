pkgs: withGUI: with pkgs; [
  # these packages are meant to be installed in all scenarios
  bat
  binutils
  cmake
  direnv
  fd
  fzf
  git
  gnupg
  nix-index
  nix-template
  nix-tree
  nix-update
  nixpkgs-fmt
  nixpkgs-review
  perl  # for fzf history
  ripgrep
  tree
  wget
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
  # these packages are only installed in linux
] ++ pkgs.lib.optionals withGUI [
  # these packages are only installed in GUI environments
]