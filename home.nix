{ config, lib, pkgs, specialArgs, ... }:

let
  #bashsettings = import ./bash.nix pkgs;
  #vimsettings = import ./vim.nix;
  packages = import ./packages.nix;

  # hacky way of determining which machine I'm running this from
  inherit (specialArgs) withGUI isDesktop networkInterface homeDirectory username;

  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = packages pkgs withGUI;
  home.homeDirectory = homeDirectory;
  home.username = username;
  home.stateVersion = "21.11";
}