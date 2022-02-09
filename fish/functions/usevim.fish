function usevim --description "Start a shell with the given Vim version." --argument-names vim py
    nix shell -f "$HOME/.dotfiles/nix/vim/default.nix" -j auto --cores 0 --argstr vimVer $vim --argstr py $py
end
