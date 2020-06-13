function usevim --description 'Set the current Vim version.' --argument-names vim py
    set -l vims '7.4' '8.0' '8.1' '8.2'
    set -l pys '2' '3'
    set -l nixpath "$HOME/.vim/nix"

    if test -z $py
        set py '3'
    end

    if not contains $vim $vims
        echo "Invalid Vim version $vim. Must be one of: $vims."
        return 1
    else if not contains $py $pys
        echo "Invalid Python version $py Must be one of: $pys."
        return 1
    end

    nix-env -f "$nixpath/vim.nix" -j auto --argstr vim $vim --argstr py $py -i vim
    return
end
