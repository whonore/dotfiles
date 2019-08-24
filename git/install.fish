#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l files ".gitconfig,$HOME/.gitconfig" "ignore,$HOME/.config/git/ignore"
source $dir/../helper.fish
install_dots $dir $files
