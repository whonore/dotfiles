{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra";
    coq-ctags.inputs.nixpkgs.follows = "nixpkgs";
    coq-ctags.url = "path:./coq.ctags";
    pash.inputs.nixpkgs.follows = "nixpkgs";
    pash.url = "path:./pash";
    peridot.inputs.nixpkgs.follows = "nixpkgs";
    peridot.url = "github:whonore/peridot";
    universal-ctags.inputs.nixpkgs.follows = "nixpkgs";
    universal-ctags.url = "path:./universal-ctags";
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
      {
        username = "wolf.honore";
        host = "sufjan";
        system = "aarch64-darwin";
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
    isDarwin = system: builtins.elem system nixpkgs.lib.platforms.darwin;
    homePath = system:
      if isDarwin system
      then "/Users"
      else "/home";
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
          homeDirectory = "${homePath system}/${username}";
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
