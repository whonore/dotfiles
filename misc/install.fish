#!/usr/bin/env fish

set -l dir (dirname (status filename))
set -l files ".ghci,$HOME/.ghci" ".vintrc.yaml,$HOME/.vintrc.yaml" ".screenrc,$HOME/.screenrc" ".fdignore,$HOME/.fdignore" "$dir/../vim/bundle/vim-blueper/tmTheme/Blueper.tmTheme,$HOME/.config/bat/themes/Blueper.tmTheme" "batconfig,$HOME/.config/bat/config"
source $dir/../helper.fish
install_dots $dir $files
if command -qs bat
    bat cache --build
end
