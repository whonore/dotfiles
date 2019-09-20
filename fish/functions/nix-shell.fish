# Redefine nix-shell to use fish
function nix-shell
    set -l com "export SHELL=$SHELL; $SHELL"
    command nix-shell --command "$com" $argv
end
