#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l files ".,$HOME/.xmonad"
set -a files ".xmobarrc,$HOME/.xmobarrc"

install_dots $dir $files
