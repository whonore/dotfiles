{ pkgs ? import <nixpkgs> { }, vimVer ? "8.2", py ? "3", gui ? false }:
with pkgs;

let vim = import ./. { inherit pkgs vimVer py gui; };
in mkShell { buildInputs = [ vim ]; }
