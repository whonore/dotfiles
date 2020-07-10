{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  coqsrc = fetchTarball https://github.com/coq/coq-on-cachix/tarball/master;
  coqPackages = mkCoqPackages (import coqsrc {});
in
with coqPackages;
stdenv.mkDerivation {
  name = "coqmaster";

  propagatedBuildInputs = [coq];
}
