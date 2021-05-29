{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  cli = {
    inherit bat;                              # 0.18.0
    inherit delta;                            # 0.7.1
    inherit exa;                              # 0.10.1
    inherit fd;                               # 8.2.1
    inherit fzf;                              # 0.27.0
    inherit ripgrep;                          # 12.1.1
    inherit xclip;                            # 0.13
    inherit zoxide;                           # 0.7.0
  };
  coq = {
    inherit coq_8_13;                         # 8.13.2
  };
  fmt = {
    inherit cppcheck;                         # 2.4
    inherit nixfmt;                           # 0.4.0
    inherit shellcheck;                       # 0.7.2
    inherit shfmt;                            # 3.2.4
  };
  nix = {
    inherit cachix;                           # 0.6.0
    inherit nix;                              # 2.3.10
  };
  qutebrowser = {
    inherit asciidoc;                         # 9.0.4
    inherit lastpass-cli;                     # 1.3.3
  };
  rust = {
    inherit rustup;                           # 1.24.1
  };
  shell = {
    inherit fish;                             # 3.2.2
  };
  vim = {
    ctags = import ./ctags { inherit pkgs; }; # 5.9.20210411.0
    vim = import ./vim { inherit pkgs; };     # 8.2.2845
  };
  xmonad = {
    inherit dmenu;                            # 5.0
    inherit xmobar;                           # 0.37
    inherit xmonad-with-packages;             # 8.10.4
  };
in cli // coq // fmt // nix // qutebrowser // rust // shell // vim // xmonad
