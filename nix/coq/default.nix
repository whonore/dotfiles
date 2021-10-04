{ pkgs ? import <nixpkgs> { }, version }:

let url_8_4 = "https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz";
in if version == "8.4" then
  (import (fetchTarball url_8_4) { }).coq_8_4
else
  pkgs.coq.override ({ inherit version; })
