function install_dots
    set -l dir $argv[1]
    for arg in $argv[2..-1]
        set -l arg (string split , $arg)
        set -l src (readlink -f $dir/$arg[1])
        set -l dst $arg[2]

        if not test -d (dirname $dst)
            mkdir -p (dirname $dst)
        end

        if not test -e $dst
            ln -v -s $src $dst
        end
    end
end
