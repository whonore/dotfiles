function trash --description 'Move files into/out of a trash directory.'
    set -l options 'h/help' 'e/empty' 'l/list'
    argparse $options -- $argv; or return

    if set -q _flag_help
        echo 'Usage: trash [-h/--help] [-e/--empty] [-l/--list] [ARGS ...]'
        return 0
    end

    # Ensure _trash_dir
    if ! set -q _trash_dir
        set -g _trash_dir "$HOME/tmp/trash"
    end
    if ! test -e $_trash_dir
        mkdir -p $_trash_dir
    end
    if ! test -d $_trash_dir
        echo "$_trash_dir must be a directory"
        return 1
    end

    set -l trash_base (basename $_trash_dir)
    set -l trash_parent (dirname $_trash_dir)

    # Empty trash
    if set -q _flag_empty
        set -l trash_empty "$trash_parent/.trash.tar.gz"

        # Check if empty tar exists
        if test -e $trash_empty
            read -l -n1 -P "Overwrite $trash_empty (y/n)? " over
            if ! string match -q -i -r '^y' $over
                return 0
            end
        end

        # Create tar
        if tar -C "$trash_parent" -czf "$trash_empty" "$trash_base"
            if set -q _flag_list
                tar -tf "$trash_empty"
            end
            rm -rf $_trash_dir
        end

        return
    end

    # List trash files
    if set -q _flag_list
        ls -A1 $_trash_dir
        return
    end

    mv $argv $_trash_dir
    return
end
