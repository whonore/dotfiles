{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    whonore.url = "github:whonore/flakes";
    whonore.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    peridot.url = "github:whonore/peridot";
    peridot.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    whonore,
    alejandra,
    peridot,
  }: let
    configs = [
      {
        username = "wolf";
        host = "tigran";
        system = "x86_64-linux";
      }
      {
        username = "wolf.honore";
        host = "Wolfs-MBP";
        system = "aarch64-darwin";
      }
    ];
    overlay = system: self: super: let
      default = flake:
        nixpkgs.lib.attrByPath
        ["packages" system "default"]
        (nixpkgs.lib.attrByPath ["defaultPackage" system] null flake)
        flake;
    in {
      alejandra = default alejandra;
      coq-ctags = whonore.packages.${system}.coq-ctags;
      peridot = default peridot;
      universal-ctags = whonore.packages.${system}.universal-ctags;
      vim = import ./vim {pkgs = super;};
    };
    homePath = system:
      if system.isDarwin
      then "/Users"
      else "/home";
  in {
    homeConfigurations = nixpkgs.lib.listToAttrs (map ({
      username,
      host,
      system,
    }: let
      systemFull = nixpkgs.lib.systems.elaborate system;
    in
      nixpkgs.lib.nameValuePair "${username}@${host}" (
        home-manager.lib.homeManagerConfiguration {
          configuration.imports = [./home.nix];

          inherit system username;
          homeDirectory = "${homePath systemFull}/${username}";
          stateVersion = "22.05";

          pkgs = import nixpkgs {
            inherit system;
            overlays = [(overlay system)];
          };

          extraSpecialArgs = {system = systemFull;};
        }
      ))
    configs);
  };
}
