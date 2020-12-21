{ pkgs ? import <nixpkgs> {}, version }:

let
  coq = "coq_" + builtins.replaceStrings ["."] ["_"] version;
  coqpkgs = if version == "8.4"
            then (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz") {})
            else pkgs;
in
  if builtins.hasAttr coq coqpkgs
  then builtins.getAttr coq coqpkgs
  else if version == "master"
       then (import (fetchTarball https://github.com/coq/coq-on-cachix/tarball/master) {})
       else abort "Invalid version ${version}"
