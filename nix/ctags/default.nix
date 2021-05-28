{ pkgs ? import <nixpkgs> {} }:
with pkgs;

universal-ctags.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [libyaml];
  doCheck = false;
})
