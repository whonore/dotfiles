#!/bin/sh
nix-env -iA $(cat packages | sed 's/#.*$//g' | sed '/^$/d' | sed 's/^/nixpkgs./')
