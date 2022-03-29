pkgs:
with pkgs; [
  ## app
  drawio               # 17.2.1
  ## cli
  bat                  # 0.20.0
  clang-tools          # 13.0.1
  delta                # 0.12.1
  exa                  # 0.10.1
  fd                   # 8.3.2
  fzf                  # 0.29.0-man
  ripgrep              # 13.0.0
  rlwrap               # 0.45.2
  rm-improved          # 0.13.0
  xclip                # 0.13
  zoxide               # 0.8.0
  ## coq
  coq_8_15             # 8.15.1
  ## fmt
  alejandra            # 1.1.0
  bibclean             # 3.06
  cppcheck             # 2.7.3-man
  nixfmt               # 0.4.0
  shellcheck           # 0.8.0-man
  shfmt                # 3.4.3
  ## fonts
  fira-code            # 6.2
  ## misc
  bitwise              # 0.43
  openconnect          # 8.10
  peridot              # 0.1.1
  ## nix
  cachix               # 0.7.0
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales         # 2.33-117
  ## qutebrowser
  asciidoc             # 9.1.0
  lastpass-cli         # 1.3.3
  ## rust
  rust-analyzer        # 2022-03-07
  rustup               # 1.24.3
  ## shell
  fish                 # 3.4.1
  pash                 # 0.6
  ## vim
  coq-ctags            # 0.0
  ctags                # 5.9.20220220.0
  vim                  # 8.2.3457
  ## xmonad
  dmenu                # 5.1
  xmobar               # 0.41
  xmonad-with-packages # 8.10.7
]