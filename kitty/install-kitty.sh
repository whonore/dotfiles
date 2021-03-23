#!/bin/sh
KITTY_ROOT=$HOME/.local/kitty.app
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/man/man1

ln -s "$KITTY_ROOT"/bin/kitty ~/.local/bin
cp -n "$KITTY_ROOT"/share/applications/kitty.desktop "$KITTY_ROOT"/share/applications/kitty.desktop.bk
sed -i "s|Icon=kitty|Icon=$KITTY_ROOT/share/icons/hicolor/256x256/apps/kitty.png|g" "$KITTY_ROOT"/share/applications/kitty.desktop
ln -s "$KITTY_ROOT"/share/applications/kitty.desktop ~/.local/share/applications
ln -s "$KITTY_ROOT"/share/man/man1/kitty.1 ~/.local/man/man1
