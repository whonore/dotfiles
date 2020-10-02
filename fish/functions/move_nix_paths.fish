function move_nix_paths --description "Move paths beginning with /nix to the start of PATH"
    set -g NIX_PATHS
    set -l idxs
    for idx in (seq 1 (count $PATH))
        if string match -q "/nix*" $PATH[$idx]
            set -a NIX_PATHS $PATH[$idx]
            set -a idxs $idx
        end
    end
    for idx in (seq 1 (count $idxs))
        set -e PATH[(math $idxs[$idx] - $idx + 1)]
    end
    set -p PATH $NIX_PATHS
end
