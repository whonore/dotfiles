{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra";
    coq-ctags.url = "path:./coq.ctags";
    coq-ctags.inputs.nixpkgs.follows = "nixpkgs";
    universal-ctags.inputs.nixpkgs.follows = "nixpkgs";
    universal-ctags.url = "path:./universal-ctags";
    pash.inputs.nixpkgs.follows = "nixpkgs";
    pash.url = "path:./pash";
    peridot.inputs.nixpkgs.follows = "nixpkgs";
    peridot.url = "github:whonore/peridot";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    coq-ctags,
    pash,
    peridot,
    universal-ctags,
  }: let
    configs = [
      {
        username = "wolf";
        host = "tigran";
        system = "x86_64-linux";
      }
    ];
    overlay = system: self: super: {
      alejandra = alejandra.defaultPackage.${system};
      coq-ctags = coq-ctags.packages.${system}.default;
      pash = pash.packages.${system}.default;
      peridot = peridot.packages.${system}.default;
      universal-ctags = universal-ctags.packages.${system}.default;
      vim = import ./vim {pkgs = super;};
    };
  in {
    homeConfigurations = nixpkgs.lib.listToAttrs (map ({
      username,
      host,
      system,
    }:
      nixpkgs.lib.nameValuePair "${username}@${host}" (
        home-manager.lib.homeManagerConfiguration {
          configuration.imports = [./home.nix];

          inherit system username;
          homeDirectory = "/home/${username}";
          stateVersion = "22.05";

          pkgs = import nixpkgs {
            inherit system;
            overlays = [(overlay system)];
          };
        }
      ))
    configs);
  };
}
