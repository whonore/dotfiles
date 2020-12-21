{ pkgs ? import <nixpkgs> {}, version }:
with pkgs;

let
  coq = import ./coq.nix { pkgs=pkgs; version=version; };
in
mkShell {
  name = "coq";
  buildInputs = [coq];
}
