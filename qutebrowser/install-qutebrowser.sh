#!/bin/sh
QUTEBROWSER_ROOT=$HOME/.qutebrowser

cd $QUTEBROWSER_ROOT
python scripts/mkvenv.py
$QUTEBROWSER_ROOT/.venv/bin/python3 -m pip install -r ~/.dotfiles/qutebrowser/requirements.txt
install -Dm755 -t ~/.local/share/qutebrowser/userscripts/ $QUTEBROWSER_ROOT/misc/userscripts/*
sed -i "s|#!/usr/bin/env python.*|#!$QUTEBROWSER_ROOT/.venv/bin/python3|" ~/.local/share/qutebrowser/userscripts/*
