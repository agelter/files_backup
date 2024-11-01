{ pkgs, withGUI, isWorkMachine }: with pkgs; [
  # these packages are meant to be installed in all scenarios
  bat
  binutils
  cmake
  direnv
  duf
  fd
  fzf
  git
  gnupg
  lsd
  nix-index
  nix-template
  nix-tree
  nix-update
  nixpkgs-fmt
  nixpkgs-review
  perl  # for fzf history
  ripgrep
  shellcheck
  tree
  wget
  zoxide

  # zsh
  zsh-powerlevel10k
  meslo-lgs-nf
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
  # these packages are only installed in linux
] ++ pkgs.lib.optionals withGUI [
  # these packages are only installed in GUI environments
] ++ pkgs.lib.optionals isWorkMachine [
  # these packages are only installed on work machines
  docker
]