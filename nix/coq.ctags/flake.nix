{
  description = "A ctags optlib parser for Coq";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in rec {
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation rec {
      pname = "coq.ctags";
      version = "0.0";
      src = pkgs.fetchFromGitHub {
        owner = "tomtomjhj";
        repo = pname;
        rev = "ac97d2551bf61e7f8d6d25b3fadbefc841eeebff";
        sha256 = "sha256-aaFD7kxyD+2SGu3iUk4wsWInLwjypL2m6WfMNhqoBKE=";
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
