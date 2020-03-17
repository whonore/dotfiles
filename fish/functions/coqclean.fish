function coqclean --description 'Delete Coq compilation files'
    set -l options 'h/help' 'a/all' 'f/force'
    argparse $options -- $argv; or return

    if set -q _flag_help
        echo 'Usage: coqclean [-h/--help] [-a/--all] [-f/--force] [dirs ...]'
        return 0
    end

    if test -z $argv[1]
        set argv[1] '.'
    end

    set -l exts 'glob' 'vo' 'time' 'aux'
    set -l extpat (string join '|' $exts)
    set -l extpat_esc (string join '\|' $exts)
    set -l pat "\.?.*\.\($extpat_esc\)"
    for d in $argv
        for f in (find $d -regex $pat)
            set -l dir (dirname $f)
            set -l base (string trim -l -c'.' (basename $f))
            set -l name (string replace -r ".($extpat)\$" '' $base)
            set -l coq "$dir/$name.v"

            if set -q _flag_all; or not test -e $coq
                echo $f
                if set -q _flag_force
                    rm $f
                end
            end
        end
    end
end

