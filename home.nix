# cSpell: words pkgs nixpkgs stdenv zshsettings
{ config, lib, pkgs, specialArgs, ... }:

let
  gitsettings = import ./nix/git.nix;
  packages = import ./nix/packages.nix;
  vimsettings = import ./nix/vim.nix;
  vscode = import ./nix/vscode.nix;
  zshsettings = import ./nix/zsh.nix;

  # hacky way of determining which machine I'm running this from
  inherit (specialArgs) configName withGUI isDesktop isWorkMachine;

  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;

  directoryExists = dir: builtins.pathExists dir && (builtins.tryEval (builtins.readDir dir)).success;
  metatronDecryptedDir = builtins.toString ./root/metatron/decrypted;
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
    sessionPath = [
      "${config.home.homeDirectory}/bin"
      "${config.home.homeDirectory}/.config/mutable_node_modules/bin"
    ];
  };

  imports = if withGUI then [
    # Source: https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa
    # Make vscode settings writable

    (import (builtins.fetchurl {
      url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/mutability.nix";
      sha256 = "4b5ca670c1ac865927e98ac5bf5c131eca46cc20abf0bd0612db955bfc979de8";
    }) { inherit config lib; })

    (import (builtins.fetchurl {
      url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/vscode.nix";
      sha256 = "fed877fa1eefd94bc4806641cea87138df78a47af89c7818ac5e76ebacbd025f";
    }) { inherit config lib pkgs; })
  ] else [];

  home.file = lib.mkMerge [
    {
      ".npmrc".source = ./configs/.npmrc;
      ".prettierrc".source = ./configs/.prettierrc;
      ".pypirc".source = ./configs/.pypirc;
      ".wakatime.cfg".source = ./configs/.wakatime.cfg;
      ".yarnrc".source = ./configs/.yarnrc;
      ".p10k.zsh".source = ./configs/.p10k.zsh;
      ".config/graphite/aliases".source = ./configs/graphite_aliases;
    }
    (lib.optionalAttrs (directoryExists metatronDecryptedDir) {
      ".config/graphite/user_config".source = "${metatronDecryptedDir}/graphite_config";
    })
    (lib.optionalAttrs (isWorkMachine) {
      ".config/git/server.gitconfig".source = ./configs/.nflxservergitconfig;

      # Newt, Metatron, etc
      ".install-netflix-tools.sh" = {
        source = ./scripts/install-netflix-tools.sh;
        executable = true;
      };
    })

  ];

  programs.git = gitsettings { inherit pkgs config isDesktop isWorkMachine withGUI; };

  programs.neovim = vimsettings pkgs;
  programs.vscode = vscode { inherit pkgs config withGUI; };
  programs.zsh = zshsettings { inherit pkgs config configName isWorkMachine; };

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
}