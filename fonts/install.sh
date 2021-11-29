#!/bin/sh
set -e

FONTS_ROOT=$HOME/.local/share/fonts
mkdir -p "$FONTS_ROOT"

version=6
zip=Fira_Code_v$version.zip
curl -fLO https://github.com/tonsky/FiraCode/releases/download/$version/$zip
unzip -o -q -d "$FONTS_ROOT"/FiraCode $zip
rm $zip

fc-cache -fvE "$FONTS_ROOT"
