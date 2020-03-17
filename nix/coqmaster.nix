{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  coqsrc = fetchTarball https://github.com/coq/coq-on-cachix/tarball/master;
  coq = callPackage coqsrc { doInstallCheck = false; buildDoc = false; };
in stdenv.mkDerivation {
  name = "coqmaster";

  buildInputs = [coq];
}
