{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  app = {
    inherit drawio;                               # 16.5.1
  }
  cli = {
    inherit bat;                                  # 0.20.0
    inherit clang-tools;                          # 13.0.0
    inherit delta;                                # 0.12.0
    inherit exa;                                  # 0.10.1
    inherit fd;                                   # 8.3.2
    inherit fzf;                                  # 0.29.0
    inherit ripgrep;                              # 13.0.0
    inherit rlwrap;                               # 0.45.2
    inherit rm-improved;                          # 0.13.0
    inherit xclip;                                # 0.13
    inherit zoxide;                               # 0.8.0
  };
  coq = {
    inherit coq;                                  # 8.15.0
  };
  fmt = {
    inherit bibclean;                             # 3.06
    inherit cppcheck;                             # 2.7
    inherit nixfmt;                               # 0.4.0
    inherit shellcheck;                           # 0.8.0-bin
    inherit shfmt;                                # 3.4.3
  };
  fonts = {
    inherit fira-code;                            # 6.2
  };
  misc = {
    inherit bitwise;                              # 0.43
    peridot = import ./peridot { inherit pkgs; }; # 0.1.1
  };
  nix = {
    inherit cachix;                               # 0.7.0
    # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
    inherit glibcLocales;
    inherit nix;                                  # 2.6.1
  };
  qutebrowser = {
    inherit asciidoc;                             # 9.1.0
    inherit lastpass-cli;                         # 1.3.3
  };
  rust = {
    inherit rust-analyzer;                        # 2022-02-28
    inherit rustup;                               # 1.24.3
  };
  shell = {
    inherit fish;                                 # 3.3.1
  };
  vim = {
    ctags = import ./ctags { inherit pkgs; };     # 5.9.20210411.0
    vim = import ./vim { inherit pkgs; };         # 8.2.3457
  };
  xmonad = {
    inherit dmenu;                                # 5.1
    inherit xmobar;                               # 0.41
    inherit xmonad-with-packages;                 # 8.10.7
  };
in cli // coq // fmt // misc // nix // qutebrowser // rust // shell // vim
// xmonad
