{ pkgs ? import <nixpkgs> { }, version ? "8.2", py ? "3", gui ? false }:
with pkgs;

let vim = import ./. { inherit pkgs version py gui; };
in mkShell { buildInputs = [ vim ]; }
