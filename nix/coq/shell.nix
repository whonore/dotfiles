{ pkgs ? import <nixpkgs> {}, version }:
with pkgs;

let
  coq = import ./. { inherit pkgs version; };
in
mkShell {
  buildInputs = [coq];
}
