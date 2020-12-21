function usecoq --description 'Start a nix-shell with the given Coq version.' --argument-names coqv
    nix-shell "$HOME/.dotfiles/nix/coqshell.nix" --argstr version $coqv -j auto $nixopts
end
