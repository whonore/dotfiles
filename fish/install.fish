#!/usr/bin/env fish

set -l dir (dirname (status filename))
source $dir/../helper.fish

set -l files ".,$HOME/.config/fish"

# Remove empty fish config directory
if not ls -1qA $HOME/.config/fish | grep -q .
    rmdir $HOME/.config/fish
end
install_dots $dir $files
