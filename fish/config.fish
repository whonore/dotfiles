if not functions -q fish_add_path
    function fish_add_path --description "Prepend a path to fish_user_paths if it's not already included"
        for p in $argv
            if not contains $p $fish_user_paths
                set -Up fish_user_paths $p
            end
        end
    end
end

set FISH_ROOT "$HOME/.config/fish"

# Load extra definitions
if test -f "$FISH_ROOT/local.fish"
    source "$FISH_ROOT/local.fish"
end

# Local bin directories
fish_add_path "$HOME/bin" "$HOME/.local/bin" "$HOME/.local/bin/setuid_scripts"
set -a MANPATH "$HOME/.local/man"
set -a INFOPATH "$HOME/.local/info"

# rust
fish_add_path "$HOME/.cargo/bin"
if command -q exa
    alias ls exa
end

# yarn
if test -d "$HOME/.yarn"
    fish_add_path "$HOME/.yarn/bin"
end

# pyenv
if test -d "$HOME/.pyenv"
    set PYENV_ROOT "$HOME/.pyenv"
    fish_add_path "$PYENV_ROOT/bin"
    pyenv init - | source
    pyenv virtualenv-init - | source
end

# rbenv
if test -d "$HOME/.rbenv"
    set RBENV_ROOT "$HOME/.rbenv"
    fish_add_path "$RBENV_ROOT/bin"
    rbenv init - | source
end

# tlmgr
set TEXLIVE_ROOT (ls -dr1 /usr/local/texlive/20* | head -n1)
if test -d "$TEXLIVE_ROOT"
    fish_add_path "$TEXLIVE_ROOT/bin/x86_64-linux"
    set -a MANPATH "$TEXLIVE_ROOT/texmf-dist/doc/man"
    set -a INFOPATH "$TEXLIVE_ROOT/texmf-dist/doc/info"
    set TEXMFHOME "$HOME/.local/texmf"
end

# fzf
set -x FZF_DEFAULT_COMMAND "fd --type f"
set -x FZF_DEFAULT_OPTS "--height=40% --reverse --cycle"
set FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND . \$dir"
set FZF_ALT_C_COMMAND "fd --type d . \$dir"

# grip
set -x GRIPHOME "$HOME/.config/grip"

# bat
set -l theme "$HOME/.config/bat/themes/Blueper.tmTheme"
set -l meta "$HOME/.cache/bat/metadata.yaml"
if command -q bat; and test -f $theme
    if test ! -f $meta; or test (stat -Lc %Y $meta) -lt (stat -Lc %Y $theme)
        bat cache --build >/dev/null
    end
end

# zoxide
if command -q zoxide
    zoxide init fish | source
end

# rm-improved
set -x GRAVEYARD "$HOME/tmp/graveyard"

# nix
set -a MANPATH "$HOME/.nix-profile/share/man"
alias nix-where "nix path-info"

# qutebrowser
if test -d "$HOME/.qutebrowser"
    set -x QUTEBROWSER_ROOT "$HOME/.qutebrowser"
end

# Browser
for browser in firefox chromium
    if command -q $browser
        set -x BROWSER $browser
        if string match -q "/snap*" (command -s $browser)
            # Snap's sandboxing prevents browsers from opening help files in /nix
            set __fish_help_dir_orig $__fish_help_dir
            set -x __fish_help_dir ""
        end
        break
    end
end

# Move /nix paths from nix-shell before fish_user_paths
if test -n "$IN_NIX_SHELL"; and ! string match -q "/nix*" $PATH[1]
    move_nix_paths
end

# Append : to MANPATH so manpath appends default system paths
set -a MANPATH :
