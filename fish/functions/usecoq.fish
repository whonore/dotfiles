function usecoq --description 'Start a nix-shell with the given Coq version.' --argument-names coqv
    set -l nixcmd ''
    if test $coqv = 'master'
        set -l coqpath "$HOME/.dotfiles/nix/coqmaster.nix"
        set -l nixopts '--extra-substituters "https://coq.cachix.org" --trusted-public-keys "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= coq.cachix.org-1:5QW/wwEnD+l2jvN6QRbRRsa4hBHG3QiQQ26cxu1F5tI="'
        set nixcmd "nix-shell -j auto $nixopts $coqpath"
    else
        set coqv (string join '_' 'coq' (string replace '.' '_' $coqv))
        set -l nixopts ''
        if test $coqv = 'coq_8_4'
            set nixopts '-I nixpkgs="https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz"'
        end
        set nixcmd "nix-shell -j auto $nixopts -p $coqv"
    end
    eval $nixcmd
end
