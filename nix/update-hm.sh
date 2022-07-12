#!/bin/bash
set -euo pipefail

TOP=$(CDPATH="" cd -- "$(dirname -- "$(readlink -- "$0")")" && pwd -P)
PROFILE="$USER@$(hostname)"
HM="path:$TOP#homeConfigurations.\"$PROFILE\".activationPackage"

cd "$TOP"

if command -v home-manager &>/dev/null; then
    OLD=$(home-manager generations | head -n1 | cut -d" " -f7)
else
    OLD=""
fi

if ! nix build --print-build-logs --verbose --no-link "$HM"; then
    echo "Failed to update home-manager packages"
    exit 1
fi

HMIDX=$(nix profile list | grep home-manager-path | cut -d" " -f1) || true
if [ -n "$HMIDX" ]; then
    nix profile remove "$HMIDX"
fi

HMPATH=$(nix path-info "$HM" 2>/dev/null)
if [ ! -d "$HMPATH" ]; then
    echo "Failed to locate home-manager path: $HMPATH"
    exit 1
fi

if ! "$HMPATH"/activate; then
    echo "Failed to activate $HMPATH"
    exit 1
fi

NEW=$(home-manager generations | head -n1 | cut -d" " -f7)
if [ "$OLD" != "$NEW" ]; then
    ./sync-version.py -q
    if [ -n "$OLD" ]; then
        nix store diff-closures "$OLD" "$NEW"
    fi
fi
