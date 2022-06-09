pkgs:
with pkgs; [
  ## app
  drawio               # 19.0.2
  ## cli
  bat                  # 0.21.0
  clang-tools          # 13.0.1
  delta                # 0.13.0
  exa                  # 0.10.1
  fd                   # 8.4.0
  fzf                  # 0.30.0-man
  ripgrep              # 13.0.0
  rlwrap               # 0.45.2
  rm-improved          # 0.13.0
  xclip                # 0.13
  zoxide               # 0.8.1
  ## coq
  coq_8_15             # 8.15.2
  ## fmt
  alejandra            # 1.4.0
  bibclean             # 3.06
  cppcheck             # 2.8
  nixfmt               # 0.5.0
  shellcheck           # 0.8.0-bin
  shfmt                # 3.5.1
  ## fonts
  fira-code            # 6.2
  ## misc
  bitwise              # 0.43
  openconnect          # 8.20
  peridot              # 0.1.1
  ## nix
  cachix               # 0.7.0
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales         # 2.34-210
  ## qutebrowser
  asciidoc             # 9.1.0
  lastpass-cli         # 1.3.3
  ## rust
  rust-analyzer        # 2022-05-17
  rustup               # 1.24.3
  ## shell
  fish                 # 3.4.1
  pash                 # 0.7
  ## vim
  coq-ctags            # 0.0
  universal-ctags      # 5.9.20220529.0
  vim                  # 8.2.4700
  ## xmonad
  dmenu                # 5.1
  xmobar               # 0.43
  xmonad-with-packages # 9.0.2
]
