{
  description = "Home-manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = { self, home-manager, nixpkgs, utils, mac-app-util }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        modules = [ (import ./home.nix) ] ++ (args.modules or []);
        pkgs = pkgsForSystem (args.system or "x86_64-linux");
      } // { inherit (args) extraSpecialArgs; });

    in utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ] (system: rec {
      legacyPackages = pkgsForSystem system;
      devShells.default = with legacyPackages; mkShell {
        packages = [ home-manager.packages.${system}.default ];
      };
  }) // {
    # non-system suffixed items should go here
    nixosModules.home = import ./home.nix; # attr set or list

    homeConfigurations.server = mkHomeConfiguration {
      extraSpecialArgs = {
        withGUI = false;
        isDesktop = false;
        isWorkMachine = true;
      };
    };

    homeConfigurations.mac = mkHomeConfiguration {
      system = "aarch64-darwin";
      modules = [
        mac-app-util.homeManagerModules.default
        ({lib,...}:
        {
          home.homeDirectory = lib.mkForce "/Users/agelter";
        })
      ];
      extraSpecialArgs = {
        withGUI = true;
        isDesktop = true;
        isWorkMachine = true;
      };
    };

    inherit home-manager;
    inherit (home-manager) packages;
  };
}
