#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l bat $HOME/.config/bat
set -l files "../vim/bundle/vim-blueper/themes/tmTheme/Blueper.tmTheme,$bat/themes/Blueper.tmTheme"
set -a files "config,$bat/config"

install_dots $dir $files
if command -qs bat
    bat cache --build
end
