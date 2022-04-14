{
  description = "Universal ctags";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in rec {
    packages.x86_64-linux.default = pkgs.universal-ctags.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [pkgs.libyaml pkgs.pcre2];
      doCheck = false;
    });
  };
}
