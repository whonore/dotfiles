set -g prompt_color_git $blueper_teal

set -g prompt_open "⦇"
set -g prompt_close "⦈"
set -g prompt_host_sep "@"
set -g prompt_git_sep "⊧"
set -g prompt_nix "+"

set -g __fish_git_prompt_char_cleanstate "✓"
set -g __fish_git_prompt_char_conflictedstate "⦸"
set -g __fish_git_prompt_char_dirtystate "±"
set -g __fish_git_prompt_char_stagedstate "⋆"
set -g __fish_git_prompt_char_stateseparator "|"
set -g __fish_git_prompt_char_untrackedfiles "⋄"
set -g __fish_git_prompt_char_upstream_ahead "⇑"
set -g __fish_git_prompt_char_upstream_behind "⇓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color $prompt_color_git
set -g __fish_git_prompt_color_branch $prompt_color_git
set -g __fish_git_prompt_color_cleanstate $blueper_green
set -g __fish_git_prompt_color_dirtystate $blueper_blue --bold
set -g __fish_git_prompt_color_invalidstate $blueper_red
set -g __fish_git_prompt_color_stagedstate $blueper_yellow
set -g __fish_git_prompt_color_untrackedfiles $prompt_color_git
set -g __fish_git_prompt_hide_untrackedfiles 1
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showupstream "informative"

function fish_prompt --description "Write out the prompt"
    set -l last_status $status

    set -l color_base $fish_color_cwd
    if test $last_status -ne 0
        set color_base $blueper_red
    end

    set -l user "$USER"
    set -l host "$hostname"
    if iscaps
        set user (string upper $user)
        set host (string upper $host)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set_color $color_base; printf $prompt_open
    set_color $fish_color_user --bold; printf $user
    set_color $color_base --bold; printf $prompt_host_sep
    set_color $fish_color_host --bold; printf $host
    if test -n "$IN_NIX_SHELL"
        set_color $color_base --bold; printf $prompt_nix
    end
    set_color normal; printf "%s" (fish_git_prompt "$prompt_git_sep%s")
    set_color $color_base; printf $prompt_close

    # If current dir is not writable display it in red
    set_color $color_base
    if not test -w (pwd)
        set_color $blueper_red --bold
    end
    printf "%s " (prompt_pwd)

    set_color normal
end
