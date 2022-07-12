#!/bin/bash
set -euo pipefail

CONF=$HOME/.config/nix/nix.conf
mkdir -p "$(dirname "$CONF")"
tee -a "$CONF" <<EOF
experimental-features = nix-command flakes
cores = 0
max-jobs = auto
EOF

nix profile install nix
