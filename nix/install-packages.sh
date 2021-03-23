#!/bin/sh
nix-env -iA "$(sed -e 's/#.*$//g' -e '/^$/d' -e 's/^/nixpkgs./' packages)"
