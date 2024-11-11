{ config, lib, pkgs, specialArgs, ... }:

let
  gitsettings = import ./nix/git.nix;
  packages = import ./nix/packages.nix;
  vimsettings = import ./nix/vim.nix;
  vscode = import ./nix/vscode.nix;
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
    stateVersion = "23.05";
  };

  home.file.".npmrc".source = ./configs/.npmrc;
  home.file.".prettierrc".source = ./configs/.prettierrc;
  home.file.".pypirc".source = ./configs/.pypirc;
  home.file.".wakatime.cfg".source = ./configs/.wakatime.cfg;
  home.file.".yarnrc".source = ./configs/.yarnrc;
  home.file.".p10k.zsh".source = ./configs/.p10k.zsh;

  programs.git = gitsettings { inherit pkgs config isDesktop; };
  programs.neovim = vimsettings pkgs;
  programs.vscode = vscode { inherit pkgs config withGUI; };
  programs.zsh = zshsettings { inherit pkgs config isWorkMachine; };

  programs.direnv = {
   enable = true;
   enableZshIntegration = true;
  };

  programs.fzf = {
   enable = true;
   enableZshIntegration = true;
  };

  programs.zoxide = {
   enable = true;
   enableZshIntegration = true;
  };

  # Newt, Metatron, etc
  home.file.".install-netflix-tools.sh" = if isWorkMachine then {
    source = ./scripts/install-netflix-tools.sh;  # Ensure the path is correct
    executable = true;
  } else lib.mkForce null;
}