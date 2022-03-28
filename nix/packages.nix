pkgs:
with pkgs; [
  ## app
  drawio # 16.5.1
  ## cli
  bat # 0.20.0
  clang-tools # 13.0.1
  delta # 0.12.1
  exa # 0.10.1
  fd # 8.3.2
  fzf # 0.29.0
  ripgrep # 13.0.0
  rlwrap # 0.45.2
  rm-improved # 0.13.0
  xclip # 0.13
  zoxide # 0.8.0
  ## coq
  coq # 8.15.0
  ## fmt
  alejandra
  bibclean # 3.06
  cppcheck # 2.7
  nixfmt # 0.4.0
  shellcheck # 0.8.0-bin
  shfmt # 3.4.3
  ## fonts
  fira-code # 6.2
  ## misc
  bitwise # 0.43
  openconnect
  peridot # 0.1.1
  ## nix
  cachix # 0.7.0
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales
  # pkgs.nix # 2.7.0
  ## qutebrowser
  asciidoc # 9.1.0
  lastpass-cli # 1.3.3
  ## rust
  rust-analyzer # 2022-03-07
  rustup # 1.24.3
  ## shell
  fish # 3.4.0
  pash
  ## vim
  ctags # 5.9.20210411.0
  coq-ctags
  vim # 8.2.3457
  ## xmonad
  dmenu # 5.1
  xmobar # 0.41
  xmonad-with-packages # 8.10.7
]
