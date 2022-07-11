{
  description = "Universal ctags";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    universal-ctags = system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      pkgs.universal-ctags.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.libyaml pkgs.pcre2];
        doCheck = false;
      });
  in {
    packages.aarch64-darwin.default = universal-ctags "aarch64-darwin";
    packages.aarch64-linux.default = universal-ctags "aarch64-linux";
    packages.i686-linux.default = universal-ctags "i686-linux";
    packages.x86_64-darwin.default = universal-ctags "x86_64-darwin";
    packages.x86_64-linux.default = universal-ctags "x86_64-linux";
  };
}
