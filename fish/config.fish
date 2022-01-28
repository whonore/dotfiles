function append_unique \
    --description "Append a value to a global variable only if it is not already present" \
    --argument-names var val
    if not set -q $var; or not contains $val $$var
        set -g -a $var $val
    end
end

# XDG Directories
set -q XDG_BIN_HOME || set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -q XDG_CACHE_HOME || set -gx XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME || set -gx XDG_STATE_HOME "$HOME/.local/state"
set -q XDG_CONFIG_DIRS || set -gx XDG_CONFIG_DIRS /etc/xdg
set -q XDG_DATA_DIRS || set -gx --path XDG_DATA_DIRS "/usr/local/share:/usr/share"

set -g FISH_ROOT "$XDG_CONFIG_HOME/fish"

# Load extra definitions
if test -f "$FISH_ROOT/local.fish"
    source "$FISH_ROOT/local.fish"
end

# Local bin directories
fish_add_path "$HOME/bin" "$XDG_BIN_HOME" "$XDG_BIN_HOME/setuid_scripts"
append_unique MANPATH "$HOME/.local/man"
append_unique INFOPATH "$HOME/.local/info"

# Package Managers
## nix
append_unique MANPATH "$HOME/.nix-profile/share/man"
append_unique INFOPATH "$HOME/.nix-profile/share/info"
alias nix-where "nix path-info"

## opam
set -g OPAM_ROOT "$HOME/.opam"
if test -d "$OPAM_ROOT"
    source "$OPAM_ROOT/opam-init/init.fish" >/dev/null 2>/dev/null
end

## pyenv
set -g PYENV_ROOT "$HOME/.pyenv"
if test -d "$PYENV_ROOT"
    fish_add_path "$PYENV_ROOT/bin"
    append_unique MANPATH "$PYENV_ROOT/man"
    pyenv init --path | source
    pyenv init - | source
    pyenv virtualenv-init - | source
end

## rbenv
set -g RBENV_ROOT "$HOME/.rbenv"
if test -d "$RBENV_ROOT"
    fish_add_path "$RBENV_ROOT/bin"
    rbenv init - | source
end

## rust
set -g CARGO_ROOT "$HOME/.cargo"
if test -d "$CARGO_ROOT"
    fish_add_path "$CARGO_ROOT/bin"
end

## tlmgr
set -g TEXLIVE_ROOT (ls -dr1 /usr/local/texlive/20* | head -n1)
if test -d "$TEXLIVE_ROOT"
    fish_add_path "$TEXLIVE_ROOT/bin/x86_64-linux"
    append_unique MANPATH "$TEXLIVE_ROOT/texmf-dist/doc/man"
    append_unique INFOPATH "$TEXLIVE_ROOT/texmf-dist/doc/info"
    set -gx TEXMFHOME "$HOME/.local/texmf"
end

## yarn
set -g YARN_ROOT "$HOME/.yarn"
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

## bibclean
set -gx BIBCLEANINI "$XDG_CONFIG_HOME/bibclean/config"

## coqtop
if command -q rlwrap
    alias coqtop "rlwrap coqtop"
end

## exa
if command -q exa
    alias ls exa
end

## fzf
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--height=40% --reverse --cycle"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND . \$dir"
set -gx FZF_ALT_C_COMMAND "fd --type d . \$dir"

## grip
set -gx GRIPHOME "$XDG_CONFIG_HOME/grip"

## mypy
set -gx MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy"

## rlwrap
set -gx RLWRAP_HOME "$XDG_STATE_HOME/rlwrap"

## pylint
set -gx PYLINTHOME "$XDG_STATE_HOME/pylint"

## qutebrowser
set -gx QUTEBROWSER_ROOT "$HOME/.qutebrowser"

## rm-improved
set -gx GRAVEYARD "$HOME/tmp/graveyard"

## zoxide
if command -q zoxide
    zoxide init fish | source
end

# User Preferences
## Browser
for browser in firefox chromium
    if command -q $browser
        set -gx BROWSER $browser
        if string match -q "/snap*" (command -s $browser)
            # Snap's sandboxing prevents browsers from opening help files in /nix
            set __fish_help_dir_orig $__fish_help_dir
            set -x __fish_help_dir ""
        end
        break
    end
end

## Editor
set -gx EDITOR vim
set -gx VISUAL vim

# Move /nix paths from nix-shell before fish_user_paths
if string match -q "/nix*" $PATH
    move_nix_paths
end

# Append : to MANPATH so manpath appends default system paths
append_unique MANPATH :
