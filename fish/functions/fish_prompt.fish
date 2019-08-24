set -l color_git 96FFFB

set -g __fish_git_prompt_char_cleanstate "✓"
set -g __fish_git_prompt_char_conflictedstate "⦸"
set -g __fish_git_prompt_char_dirtystate "±"
set -g __fish_git_prompt_char_stagedstate "⋆"
set -g __fish_git_prompt_char_stateseparator "|"
set -g __fish_git_prompt_char_untrackedfiles "⋄"
set -g __fish_git_prompt_char_upstream_ahead "⇑"
set -g __fish_git_prompt_char_upstream_behind "⇓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_color $color_git
set -g __fish_git_prompt_color_branch $color_git
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_dirtystate blue --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_untrackedfiles $color_git
set -g __fish_git_prompt_hide_untrackedfiles 1
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showupstream "informative"

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set -l color_prompt FFCC00
    set -l color_user 16A800
    set -l color_host C800CC

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set_color $color_prompt; printf '⦇'
    set_color $color_user --bold; printf '%s' (whoami)
    set_color $color_prompt --bold; printf '@'
    set_color $color_host --bold; printf '%s' (hostname -s)
    set_color normal; printf '%s' (__fish_git_prompt '⊧%s')
    set_color $color_prompt; printf '⦈'

    # If current dir is not writable display it in red
    set_color $color_prompt
    if not [ -w (pwd) ]
        set_color red --bold
    end
    printf '%s ' (prompt_pwd)
end
