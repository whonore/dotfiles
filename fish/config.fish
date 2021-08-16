if not functions -q fish_add_path
    function fish_add_path --description "Prepend a path to fish_user_paths if it's not already included"
        for p in $argv
            if not contains $p $fish_user_paths
                set -Up fish_user_paths $p
            end
        end
    end
end

# XDG Directories
set -q XDG_BIN_HOME || set XDG_BIN_HOME "$HOME/.local/bin"
set -q XDG_CACHE_HOME || set XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME || set XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME || set XDG_STATE_HOME "$HOME/.local/state"
set -q XDG_CONFIG_DIRS || set XDG_CONFIG_DIRS "/etc/xdg"
set -q XDG_DATA_DIRS || set XDG_DATA_DIRS "/usr/local/share:/usr/share"

set FISH_ROOT "$XDG_CONFIG_HOME/fish"

# Load extra definitions
if test -f "$FISH_ROOT/local.fish"
    source "$FISH_ROOT/local.fish"
end

# Local bin directories
fish_add_path "$HOME/bin" "$XDG_BIN_HOME" "$XDG_BIN_HOME/setuid_scripts"
set -a MANPATH "$HOME/.local/man"
set -a INFOPATH "$HOME/.local/info"

# Package Managers
## nix
set -a MANPATH "$HOME/.nix-profile/share/man"
alias nix-where "nix path-info"

## pyenv
set PYENV_ROOT "$HOME/.pyenv"
if test -d "$PYENV_ROOT"
    fish_add_path "$PYENV_ROOT/bin"
    pyenv init --path | source
    pyenv init - | source
    pyenv virtualenv-init - | source
end

## rbenv
set RBENV_ROOT "$HOME/.rbenv"
if test -d "$RBENV_ROOT"
    fish_add_path "$RBENV_ROOT/bin"
    rbenv init - | source
end

## rust
set CARGO_ROOT "$HOME/.cargo"
if test -d "$CARGO_ROOT"
    fish_add_path "$CARGO_ROOT/bin"
end

## tlmgr
set TEXLIVE_ROOT (ls -dr1 /usr/local/texlive/20* | head -n1)
if test -d "$TEXLIVE_ROOT"
    fish_add_path "$TEXLIVE_ROOT/bin/x86_64-linux"
    set -a MANPATH "$TEXLIVE_ROOT/texmf-dist/doc/man"
    set -a INFOPATH "$TEXLIVE_ROOT/texmf-dist/doc/info"
    set TEXMFHOME "$HOME/.local/texmf"
end

## yarn
set YARN_ROOT "$HOME/.yarn"
if test -d "$YARN_ROOT"
    fish_add_path "$YARN_ROOT/bin"
end

# Programs
## bat
set -l theme "$XDG_CONFIG_HOME/bat/themes/Blueper.tmTheme"
set -l meta "$XDG_CACHE_HOME/bat/metadata.yaml"
if command -q bat; and test -f $theme
    if test ! -f $meta; or test (stat -Lc %Y $meta) -lt (stat -Lc %Y $theme)
        bat cache --build >/dev/null
    end
end

## exa
if command -q exa
    alias ls exa
end

## fzf
set -x FZF_DEFAULT_COMMAND "fd --type f"
set -x FZF_DEFAULT_OPTS "--height=40% --reverse --cycle"
set FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND . \$dir"
set FZF_ALT_C_COMMAND "fd --type d . \$dir"

## grip
set -x GRIPHOME "$XDG_CONFIG_HOME/grip"

## pylint
set -x PYLINTHOME "$XDG_STATE_HOME/pylint"

## qutebrowser
set -x QUTEBROWSER_ROOT "$HOME/.qutebrowser"

## rm-improved
set -x GRAVEYARD "$HOME/tmp/graveyard"

## zoxide
if command -q zoxide
    zoxide init fish | source
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
