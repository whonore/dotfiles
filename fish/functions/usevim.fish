function usevim --description 'Start a shell with the given Vim version.' --argument-names vim py
    nix-shell "$HOME/.dotfiles/nix/vim/shell.nix" -j auto --argstr version $vim --argstr py $py
end
