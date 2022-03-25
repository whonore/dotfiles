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
        rev = "e03166eef9db79f618af4cba6ac35b2eec4c9d47";
        sha256 = "sha256-4hJ2wGvSfLrYr+FPPXxigI3v4DSJnPlByOeFWP1cSwM=";
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
