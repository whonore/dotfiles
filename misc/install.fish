#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l files ".ghci,$HOME/.ghci" ".vintrc.yaml,$HOME/.vintrc.yaml"
source $dir/../helper.fish
install_dots $dir $files
