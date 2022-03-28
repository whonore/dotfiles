{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: let
    configs = [
      {
        username = "wolf";
        host = "tigran";
      }
    ];
  in {
    homeConfigurations = nixpkgs.lib.listToAttrs (map ({
      username,
      host,
    }:
      nixpkgs.lib.nameValuePair "${username}@${host}" (
        home-manager.lib.homeManagerConfiguration {
          configuration.imports = [./home.nix];

          system = "x86_64-linux";
          homeDirectory = "/home/${username}";
          inherit username;
          stateVersion = "22.05";
        }
      ))
    configs);
  };
}
