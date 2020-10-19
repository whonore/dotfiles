#!/bin/sh
QUTEBROWSER_ROOT=$HOME/.qutebrowser
mkdir -p ~/.local/man/man1

cd $QUTEBROWSER_ROOT
python scripts/mkvenv.py
.venv/bin/python3 -m pip install -r ~/.dotfiles/qutebrowser/requirements.txt
.venv/bin/python3 scripts/dev/update_3rdparty.py
make -f misc/Makefile man

install -Dm755 -t ~/.local/share/qutebrowser/userscripts $QUTEBROWSER_ROOT/misc/userscripts/*
sed -i "s|#!/usr/bin/env python.*|#!$QUTEBROWSER_ROOT/.venv/bin/python3|" ~/.local/share/qutebrowser/userscripts/*
ln -sf $QUTEBROWSER_ROOT/doc/qutebrowser.1 ~/.local/man/man1
