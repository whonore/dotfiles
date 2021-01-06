{ pkgs ? import <nixpkgs> {}, version }:
with pkgs;

let
  coq = import ./coq.nix { inherit pkgs version; };
in
mkShell {
  name = "coq";
  buildInputs = [coq];
}
