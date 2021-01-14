{ pkgs ? import <nixpkgs> {}, version }:
with pkgs;

let
  coq = import ./. { inherit pkgs version; };
in
mkShell {
  name = "coq";
  buildInputs = [coq];
}
