#!/bin/bash
set -euo pipefail

function yes_no {
    while true; do
        read -r -p "$* [y/n]: " yn
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

if [ -z "$1" ]; then
    echo "Usage: $0 DST"
    exit 1
fi
DST="$1"

if [ ! -d "$DST" ]; then
    echo "$DST does not exist"
    exit 1
fi

DATE=$(date "+%Y-%m-%dT%H:%M:%S")

# No slash to copy directory
SRC=$HOME/Documents
DIR=backups/$(hostname)-$USER
DST=$DST/$DIR

CURRENT=$DST/backup-$DATE
LATEST=$DST/latest

if ! yes_no "Backup $SRC to $DST?"; then
    exit 1
fi

mkdir -p "$DST"

rsync \
    --recursive \
    --archive \
    --partial \
    --info=name,progress2,stats2,symsafe,flist2 \
    --human-readable \
    --link-dest="$LATEST" \
    --filter='dir-merge,- .gitignore' \
    "$SRC" "$CURRENT"

ln -sfT "$CURRENT" "$LATEST"
