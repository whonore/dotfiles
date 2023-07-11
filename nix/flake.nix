{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    whonore.url = "github:whonore/flakes";
    whonore.inputs.nixpkgs.follows = "nixpkgs";

    peridot.url = "github:whonore/peridot";
    peridot.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, whonore, peridot, }:
    let
      configs = [
        {
          username = "wolf";
          host = "tigran";
          system = "x86_64-linux";
        }
        {
          username = "wolf.honore";
          host = "Wolfs-MacBook-Pro.local";
          system = "aarch64-darwin";
        }
      ];
      overlay = system: self: super:
        let
          default = flake:
            nixpkgs.lib.attrByPath [ "packages" system "default" ]
            (nixpkgs.lib.attrByPath [ "defaultPackage" system ] null flake)
            flake;
        in {
          coq-ctags = whonore.packages.${system}.coq-ctags;
          peridot = default peridot;
          universal-ctags = whonore.packages.${system}.universal-ctags;
          vim = whonore.packages.${system}.vim;
        };
      homePath = system: if system.isDarwin then "/Users" else "/home";
    in {
      homeConfigurations = nixpkgs.lib.listToAttrs (map
        ({ username, host, system, }:
          let systemFull = nixpkgs.lib.systems.elaborate system;
          in nixpkgs.lib.nameValuePair "${username}@${host}"
          (home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ (overlay system) ];
            };

            modules = [
              ./home.nix
              {
                home = {
                  inherit username;
                  homeDirectory = "${homePath systemFull}/${username}";
                  stateVersion = "22.11";
                };
              }
            ];

            extraSpecialArgs = { system = systemFull; };
          })) configs);
    };
}
