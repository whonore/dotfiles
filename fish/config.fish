# Local bin directories
set -p PATH "$HOME/bin" "$HOME/.local/bin"

# Yarn
set -p PATH "$HOME/.yarn/bin"

# Pyenv
set PYENV_ROOT "$HOME/.pyenv"
set PATH "$PYENV_ROOT/bin" $PATH
pyenv init - | source
pyenv virtualenv-init - | source

# Pipenv
eval (pipenv --completion)

# tlmgr
set TEXMFHOME "$HOME/.local/texmf"

# Coq 8.4
alias coq-84 'nix-shell -I nixpkgs="https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz" -p coq_8_4 --command fish'

alias nix-fish 'nix-shell --command fish'
