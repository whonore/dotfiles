function usecoq --description "Start a shell with the given Coq version." --argument-names coqv
    nix shell -f "$HOME/.dotfiles/nix/coq/default.nix" -j auto --cores 0 --argstr version $coqv
end
