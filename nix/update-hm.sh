#!/bin/sh
set -e

HMIDX=$(nix profile list | grep home-manager-path | cut -d' ' -f1)
if [ -n "$HMIDX" ]; then
    nix profile remove "$HMIDX"
fi

nix build --no-link .#homeConfigurations.$USER@$(hostname).activationPackage
"$(nix path-info .#homeConfigurations.$USER@$(hostname).activationPackage)"/activate
