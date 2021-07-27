{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  cli = {
    inherit bat;                                  # 0.18.2
    inherit delta;                                # 0.8.3
    inherit exa;                                  # 0.10.1
    inherit fd;                                   # 8.2.1
    inherit fzf;                                  # 0.27.2
    inherit ripgrep;                              # 13.0.0
    inherit rm-improved;                          # 0.13.0
    inherit xclip;                                # 0.13
    inherit zoxide;                               # 0.7.2
  };
  coq = {
    inherit coq_8_13;                             # 8.13.2
  };
  fmt = {
    inherit cppcheck;                             # 2.5
    inherit nixfmt;                               # 0.4.0
    inherit shellcheck;                           # 0.7.2
    inherit shfmt;                                # 3.3.0
  };
  misc = {
    inherit bitwise;                              # 0.42
    peridot = import ./peridot { inherit pkgs; }; # 0.1.1
  };
  nix = {
    inherit cachix;                               # 0.6.1
    inherit nix;                                  # 2.3.10
  };
  qutebrowser = {
    inherit asciidoc;                             # 9.1.0
    inherit lastpass-cli;                         # 1.3.3
  };
  rust = {
    inherit rustup;                               # 1.24.2
  };
  shell = {
    inherit fish;                                 # 3.3.1
  };
  vim = {
    ctags = import ./ctags { inherit pkgs; };     # 5.9.20210411.0
    vim = import ./vim { inherit pkgs; };         # 8.2.2845
  };
  xmonad = {
    inherit dmenu;                                # 5.0
    inherit xmobar;                               # 0.38
    inherit xmonad-with-packages;                 # 8.10.4
  };
in cli // coq // fmt // misc // nix // qutebrowser // rust // shell // vim
// xmonad
