{ pkgs ? import <nixpkgs> { }, version }:

let
  url_8_4 = "https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz";
  url_master = "https://github.com/coq/coq-on-cachix/tarball/master";
  coq = "coq_" + builtins.replaceStrings [ "." ] [ "_" ] version;
  coqpkgs =
    if version == "8.4" then import (fetchTarball url_8_4) { } else pkgs;
in if builtins.hasAttr coq coqpkgs then
  builtins.getAttr coq coqpkgs
else if version == "master" then
  import (fetchTarball url_master) { }
else
  abort "Invalid version ${version}"
