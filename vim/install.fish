#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l nvim $HOME/.config/nvim
set -l files ".,$HOME/.vim"
set -a files ".vimrc,$HOME/.vimrc"
set -a files "autoload,$nvim/autoload"
set -a files "bundle,$nvim/bundle"
set -a files "colors,$nvim/colors"
set -a files ".vimrc,$nvim/init.vim"

install_dots $dir $files
