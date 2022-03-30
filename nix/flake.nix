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
    ctags.inputs.nixpkgs.follows = "nixpkgs";
    ctags.url = "path:./ctags";
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
    ctags,
    pash,
    peridot,
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
      ctags = ctags.packages.${system}.default;
      pash = pash.packages.${system}.default;
      peridot = peridot.packages.${system}.default;
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

          inherit system;
          homeDirectory = "/home/${username}";
          inherit username;
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
