function git_remote_toggle --description 'Switch git repository between HTTPS and SSH'
    set -l options h/help q/quiet S/ssh H/https
    argparse $options -- $argv; or return

    if set -q _flag_help
        echo 'Usage: trash [-h/--help] [-q/--quiet] [-S/--ssh] [-H/--https] [remotes ...]'
        return 0
    end

    if set -q _flag_ssh; and set -q _flag_https
        echo 'Must choose only one of --ssh and --https'
        return 1
    end

    if ! __grt_in_git
        echo 'Not in a git repository'
        return 1
    end

    for remote in $argv
        set -l url (git remote get-url $remote 2>/dev/null)
        set -l newurl

        if test -z "$url"
            if ! set -q _flag_quiet
                echo "Remote $remote does not exist"
            end
            continue
        else if __grt_is_ssh $url; and ! set -q _flag_ssh
            set newurl (__grt_to_https $url)
        else if __grt_is_https $url; and ! set -q _flag_https
            set newurl (__grt_to_ssh $url)
        end

        if test -n "$newurl"
            # Sanity check
            if __grt_is_ssh $url; and __grt_is_https $newurl
            else if __grt_is_https $url; and __grt_is_ssh $newurl
            else
                echo "Something went wrong: $url -> $newurl"
                continue
            end

            if ! set -q _flag_quiet
                echo "$remote: $url -> $newurl"
            end
            git remote set-url $remote $newurl
        end
    end
end

# git@github.com:{repo} -> https://github.com/{repo}
function __grt_to_https
    set -l url (string replace ':' '/' $argv)
    set -l url (string replace 'git@' 'https://' $url)
    echo $url
end

# https://github.com/{repo} -> git@github.com:{repo}
function __grt_to_ssh
    set -l url (string replace 'https://' 'git@' $argv)
    set -l url (string replace '/' ':' $url)
    echo $url
end

function __grt_is_ssh
    string match -qr '^git@' $argv
end

function __grt_is_https
    string match -qr '^https://' $argv
end

function __grt_in_git
    git status 2&>/dev/null
end
