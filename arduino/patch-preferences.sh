#!/bin/sh
set -e

die() {
    echo "$*" 1>&2
    exit 1
}

ARDUINO_ROOT=~/.arduino15
patch -s --dry-run $ARDUINO_ROOT/preferences.txt preferences.txt.patch || die "Can't apply patch"
patch -b -V numbered $ARDUINO_ROOT/preferences.txt preferences.txt.patch
sed -i "s|sketchbook\.path=.*|sketchbook.path=$HOME/.local/Arduino|" $ARDUINO_ROOT/preferences.txt
sed -i "s|theme\.file=.*|theme.file=user:blueper.zip|" $ARDUINO_ROOT/preferences.txt
