#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l nvim $HOME/.config/nvim
set -l files ".,$HOME/.vim" ".vimrc,$HOME/.vimrc" "autoload,$nvim/autoload" "bundle,$nvim/bundle" "colors,$nvim/colors" ".vimrc,$nvim/init.vim"
source $dir/../helper.fish
install_dots $dir $files
