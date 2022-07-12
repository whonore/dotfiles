#!/bin/bash
set -euo pipefail

TOP=$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd -P)
PROFILE="$USER@$(hostname)"
HM="path:$TOP#homeConfigurations.\"$PROFILE\".activationPackage"

cd "$TOP"

if command -v home-manager; then
    OLD=$(home-manager generations | head -n1 | cut -d" " -f7)
else
    OLD=""
fi

if ! nix build --print-build-logs --verbose --no-link "$HM"; then
    echo "Failed to update home-manager packages"
    exit 1
fi

HMIDX=$(nix profile list | grep home-manager-path | cut -d" " -f1)
if [ -n "$HMIDX" ]; then
    nix profile remove "$HMIDX"
fi

"$(nix path-info "$HM")"/activate

NEW=$(home-manager generations | head -n1 | cut -d" " -f7)
if [ "$OLD" != "$NEW" ]; then
    ./sync-version.py -q
    if [ -n "$OLD" ]; then
        nix store diff-closures "$OLD" "$NEW"
    fi
fi
