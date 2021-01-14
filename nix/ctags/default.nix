{ pkgs ? import <nixpkgs> {} }:
with pkgs;

(universal-ctags.override { pythonPackages = python3Packages; }).overrideAttrs (oldAttrs: {
  version = "2020-10-6";
  src = fetchFromGitHub {
    owner = "universal-ctags";
    repo = "ctags";
    rev = "e852ee0e939802331dc3117fd85a31b243c3d04f";
    sha256 = "0x5q5hdp4dzcm2i0ilc5mh5bvx87g8qsrivf8bbxhnxbz5kcwgav";
  };
  buildInputs = oldAttrs.buildInputs ++ [libyaml];
  doCheck = false;
})
