{ pkgs, withGUI, isWorkMachine }: with pkgs; [
  # these packages are meant to be installed in all scenarios
  bat
  binutils
  clang-tools
  cmake
  direnv
  duf
  fd
  fzf
  git
  git-secret
  gnupg
  graphite-cli
  lsd
  meson
  nix-index
  nix-template
  nix-tree
  nix-update
  nixpkgs-fmt
  nixpkgs-review
  nodejs
  python3
  ripgrep
  shellcheck
  tree
  wakatime
  wget
  zoxide

  # zsh
  zsh-powerlevel10k
  meslo-lgs-nf
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
  # these packages are only installed in linux
  perl  # for fzf history
] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
  # these packages are only installed in MacOs
  stats
] ++ pkgs.lib.optionals withGUI [
  # these packages are only installed in GUI environments
] ++ pkgs.lib.optionals isWorkMachine [
  # these packages are only installed on work machines
]
