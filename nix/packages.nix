pkgs:
with pkgs; [
  ## app
  drawio               # 19.0.3
  ## cli
  bat                  # 0.21.0
  clang-tools          # 13.0.1
  delta                # 0.13.0
  exa                  # 0.10.1-man
  fd                   # 8.4.0
  fzf                  # 0.30.0-man
  ripgrep              # 13.0.0
  rlwrap               # 0.45.2
  rm-improved          # 0.13.0
  xclip                # 0.13
  zoxide               # 0.8.2
  ## coq
  coq_8_15             # 8.15.2
  ## fmt
  alejandra            # 1.5.0
  bibclean             # 3.06
  cppcheck             # 2.8
  nixfmt               # 0.5.0
  shellcheck           # 0.8.0-doc
  shfmt                # 3.5.1
  ## fonts
  fira-code            # 6.2
  ## misc
  bitwise              # 0.43
  openconnect          # 9.01
  peridot              # 0.1.1
  ## nix
  cachix               # 0.7.1
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales         # 2.34-210
  ## qutebrowser
  asciidoc             # 10.2.0
  lastpass-cli         # 1.3.3
  ## rust
  rust-analyzer        # 2022-06-13
  rustup               # 1.24.3
  ## shell
  fish                 # 3.5.0
  pash                 # 0.7
  ## vim
  coq-ctags            # 0.0
  universal-ctags      # 5.9.20220529.0
  vim                  # 8.2.5172
  ## xmonad
  dmenu                # 5.1
  xmobar               # 0.43
  xmonad-with-packages # 9.0.2
]
