{ pkgs, withGUI, isWorkMachine }: with pkgs; [
  # these packages are meant to be installed in all scenarios
  _1password-cli
  bat
  binutils
  clang-tools
  cmake
  direnv
  duf
  fd
  fzf
  git
  gnupg
  graphite-cli
  lsd
  meson
  ninja
  nix-index
  nix-template
  nix-tree
  nix-update
  nixpkgs-fmt
  nixpkgs-review
  nodejs
  (python3.withPackages (ppkgs: [
    # Add more Python packages here as needed
    ppkgs.pillow
  ]))
  ripgrep
  shellcheck
  tmux
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
  groovy
]
