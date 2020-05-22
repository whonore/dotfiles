#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l files ".ghci,$HOME/.ghci"
set -a files ".vintrc.yaml,$HOME/.vintrc.yaml"
set -a files ".screenrc,$HOME/.screenrc"
set -a files ".fdignore,$HOME/.fdignore"

install_dots $dir $files
