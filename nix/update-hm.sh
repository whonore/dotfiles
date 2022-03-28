#!/bin/sh
set -e

PROFILE="$USER@$(hostname)"
if ! nix build --no-link .#homeConfigurations.$PROFILE.activationPackage; then
    echo "Failed to update home-manager packages"
    exit 1
fi

HMIDX=$(nix profile list | grep home-manager-path | cut -d' ' -f1)
if [ -n "$HMIDX" ]; then
    nix profile remove "$HMIDX"
fi

"$(nix path-info .#homeConfigurations.$PROFILE.activationPackage)"/activate
./sync-version.py -q
