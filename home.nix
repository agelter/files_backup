{ config, lib, pkgs, specialArgs, ... }:

let
  gitsettings = import ./nix/git.nix;
  packages = import ./nix/packages.nix;
  vimsettings = import ./nix/vim.nix;
  zshsettings = import ./nix/zsh.nix;

  # hacky way of determining which machine I'm running this from
  inherit (specialArgs) withGUI isDesktop isWorkMachine;

  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home = {
    packages = packages { inherit pkgs withGUI isWorkMachine; };
    homeDirectory = "/home/agelter";
    username = "agelter";
    stateVersion = "21.11";
  };

  home.file.".npmrc".source = ./configs/.npmrc;
  home.file.".prettierrc".source = ./configs/.prettierrc;
  home.file.".pypirc".source = ./configs/.pypirc;
  home.file.".wakatime.cfg".source = ./configs/.wakatime.cfg;
  home.file.".yarnrc".source = ./configs/.yarnrc;
  home.file.".p10k.zsh".source = ./configs/.p10k.zsh;

  programs.git = gitsettings { inherit pkgs config isDesktop; };
  programs.neovim = vimsettings pkgs;
  programs.zsh = zshsettings { inherit pkgs config isWorkMachine; };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode.enable = withGUI;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Newt
  home.file.".newt-install.sh".source = if isWorkMachine then ./scripts/newt-install.sh else lib.mkForce null;
  home.activation.installNewt = if isWorkMachine then lib.hm.dag.entryAfter [ ]
    ''
      # Run the newt installation script
      if [ ! -f "$HOME/.newt_installed" ]; then
        ${config.home.homeDirectory}/.newt-install.sh
        touch "$HOME/.newt_installed"
      fi
    ''
  else lib.mkForce null;
}