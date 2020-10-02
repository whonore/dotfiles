function add_path_uniq --description "Prepend a path to PATH if it's not already included"
    for p in $argv
        if not contains $p $PATH
            set -p PATH $p
        end
    end
end

set -l FISH_HOME "$HOME/.config/fish"

# Load extra definitions
if test -f "$FISH_HOME/local.fish"
    source "$FISH_HOME/local.fish"
end

# Local bin directories
add_path_uniq "$HOME/bin" "$HOME/.local/bin"
set -a MANPATH "$HOME/.local/man"
set -a INFOPATH "$HOME/.local/info"

# nix
if test -d "$HOME/.nix-profile"; and test -d /nix
    # Generated with https://gist.github.com/whonore/05abc83f9c741ff60583b5acefd7336d
    source "$HOME/.config/fish/conf.d/nix.fish"
end

# rust
add_path_uniq "$HOME/.cargo/bin"
if command -q exa
    alias ls exa
end

# yarn
if test -d "$HOME/.yarn"
    add_path_uniq "$HOME/.yarn/bin"
end

# pyenv
if test -d "$HOME/.pyenv"
    set PYENV_ROOT "$HOME/.pyenv"
    add_path_uniq "$PYENV_ROOT/bin"
    pyenv init - | source
    pyenv virtualenv-init - | source
end

# rbenv
if test -d "$HOME/.rbenv"
    set RBENV_ROOT "$HOME/.rbenv"
    add_path_uniq "$RBENV_ROOT/bin"
    rbenv init - | source
end

# tlmgr
set TEXLIVE_HOME "/usr/local/texlive/2020"
if test -d "$TEXLIVE_HOME"
    add_path_uniq "$TEXLIVE_HOME/bin/x86_64-linux"
    set -a MANPATH "$TEXLIVE_HOME/texmf-dist/doc/man"
    set -a INFOPATH "$TEXLIVE_HOME/texmf-dist/doc/info"
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
        bat cache --build > /dev/null
    end
end

# Clean up
function clean_nix_path --description "Clean up PATH if started by nix-shell"
    set -l first_nix 1
    for idx in (seq (count $PATH))
        if string match -e -q "/nix" $PATH[$idx]
            set first_nix $idx
            break
        end
    end
    if test $first_nix -ne 1
        set -e PATH[1..(math $first_nix - 1)]
    end
end

if test -n "$IN_NIX_SHELL"
    clean_nix_path
end
functions -e add_path_uniq clean_nix_path
