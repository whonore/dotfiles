function usecoq --description "Start a shell with the given Coq version." --argument-names coqv
    nix-shell "$HOME/.dotfiles/nix/coq/shell.nix" -j auto --argstr version $coqv
end
