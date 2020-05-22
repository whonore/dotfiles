#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l files ".gitconfig,$HOME/.gitconfig"
set -a files "ignore,$HOME/.config/git/ignore"

install_dots $dir $files
