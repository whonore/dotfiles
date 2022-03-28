#!/bin/sh
set -e

nix build --no-link .#homeConfigurations.$USER@$(hostname).activationPackage
"$(nix path-info .#homeConfigurations.$USER@$(hostname).activationPackage)"/activate
