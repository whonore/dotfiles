{ pkgs, system, }:

let
  missing-platforms = let
    name_or = pkg:
      pkgs.lib.mapNullable (pkg: pkg.name) (builtins.getAttr pkg pkgs);
  in builtins.listToAttrs (builtins.map (xs:
    let
      pkg = (builtins.elemAt xs 0);
      plat = builtins.elemAt xs 1;
    in pkgs.lib.nameValuePair (if pkg != null then pkg else "__null") plat) [
      [ (name_or "xmonad-with-packages") pkgs.lib.platforms.linux ]
      [ (name_or "glibcLocales") pkgs.lib.platforms.linux ]
    ]);
  platforms = pkg:
    let
      good = pkgs.lib.attrByPath [ "meta" "platforms" ]
        (builtins.getAttr pkg.name missing-platforms) pkg;
      bad = pkgs.lib.attrByPath [ "meta" "badPlatforms" ] [ ] pkg;
    in builtins.filter (sys: !(builtins.elem sys bad)) good;
  supportsSys = sys: system.canExecute (pkgs.lib.systems.elaborate sys);
  supports = pkg:
    pkgs.lib.isAttrs pkg && builtins.any supportsSys (platforms pkg);
in with pkgs;
builtins.filter supports [
  ## cli
  bat                  # 0.26.1
  clang-tools          # 21.1.8
  delta                # 0.19.2
  eza                  # 0.23.4
  fd                   # 10.4.2
  fzf                  # 0.72.0
  ripgrep              # 15.1.0
  rlwrap               # 0.48
  rm-improved          # 0.13.1
  xclip                # 0.13
  zoxide               # 0.9.9
  ## fmt
  bibclean             # 3.07
  cppcheck             # 2.18.3
  nixfmt               # 1.2.0
  shellcheck           # 0.11.0
  shfmt                # 3.13.1
  ## fonts
  fira-code            # 6.2
  ## misc
  peridot              # 0.1.1
  ## nix
  cachix               # 1.11.1
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales         # 2.42-61
  ## qutebrowser
  asciidoc             # 10.2.1
  bitwarden-cli        # 2026.4.1
  ## rust
  rustup               # 1.29.0
  ## shell
  fish                 # 4.7.1
  ## verification
  coq_8_17             # 8.17.1
  dafny                # 4.11.0
  ## vim
  coq-ctags            # 0.0.0
  solidity-ctags       # 0.0.2
  universal-ctags      # 6.2.1
  vim                  # 9.2.0043
  ## xmonad
  dmenu                # 5.4
  xmobar               # 0.50
  xmonad-with-packages # 9.10.3
]
