function coqclean --description "Delete Coq compilation files"
    set -l options h/help a/all f/force "d/depth=?"
    argparse $options -- $argv; or return

    if set -q _flag_help
        echo "Usage: coqclean [-h/--help] [-a/--all] [-f/--force] [-d/--depth] [dirs ...]"
        return 0
    end

    if test -z $argv[1]
        set argv[1] "."
    end

    set -l exts glob vo vok vos time aux
    set -l extpat (string join "|" $exts)
    set -l extpat_esc (string join "\|" $exts)
    set -l pat "\.?.*\.($extpat)\$"
    set -l pat_esc "\.?.*\.\($extpat_esc\)\$"

    if command -q fd
        function _find -a dir -V pat -V _flag_depth
            if test -z $_flag_depth
                fd --no-ignore --hidden --case-sensitive $pat $dir
            else
                fd --no-ignore --hidden --case-sensitive $pat $dir --max-depth $_flag_depth
            end
        end
    else
        function _find -a dir -V pat_esc -V _flag_depth
            if test -z $_flag_depth
                find $dir -regex $pat_esc
            else
                find $dir -maxdepth $_flag_depth -regex $pat_esc
            end
        end
    end

    for d in $argv
        for f in (_find $d)
            set -l dir (dirname $f)
            set -l base (string trim -l -c"." (basename $f))
            set -l name (string replace -r ".($extpat)\$" "" $base)
            set -l coq "$dir/$name.v"

            if set -q _flag_all; or not test -e $coq
                echo $f
                if set -q _flag_force
                    rm $f
                end
            end
        end
    end

    functions --erase _find
end
