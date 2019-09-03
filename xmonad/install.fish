#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l files ".,$HOME/.xmonad" ".xmobarrc,$HOME/.xmobarrc"
source $dir/../helper.fish
install_dots $dir $files
