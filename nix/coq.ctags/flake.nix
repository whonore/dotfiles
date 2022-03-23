{
  description = "A ctags optlib parser for Coq";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in rec {
    defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation rec {
      pname = "coq.ctags";
      version = "0.0";
      src = pkgs.fetchFromGitHub {
        owner = "tomtomjhj";
        repo = pname;
        rev = "6e28e8a7d937794f58a95c66ecfe6689e9dba28c";
        sha256 = "sha256-Mfdma+a4A9Z4EyxaEt94ncOddT7Fic4tZeJpaKcXtUs=";
      };

      dontConfigure = true;
      dontBuild = true;

      installPhase = ''
        runHook preInstall

        install -Dm644 coq.ctags "$out/share/ctags.d/optlib/coq.ctags"

        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "Universal Ctags optlib parser for Coq";
        homepage = "https://github.com/tomtomjhj/coq.ctags";
      };
    };
  };
}
