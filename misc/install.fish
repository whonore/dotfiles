#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l files ".ghci,$HOME/.ghci" ".vintrc.yaml,$HOME/.vintrc.yaml" ".screenrc,$HOME/.screenrc" ".fdignore,$HOME/.fdignore"
source $dir/../helper.fish
install_dots $dir $files
