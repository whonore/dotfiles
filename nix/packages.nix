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
  bat                  # 0.24.0
  clang-tools          # 17.0.6
  delta                # 0.17.0
  eza                  # 0.18.10
  fd                   # 9.0.0
  fzf                  # 0.50.0
  ripgrep              # 14.1.0
  rlwrap               # 0.46.1
  rm-improved          # 0.13.1
  xclip                # 0.13
  zoxide               # 0.9.4
  ## fmt
  bibclean             # 3.07
  cppcheck             # 2.13.4
  nixfmt               # 0.6.0
  shellcheck           # 0.10.0
  shfmt                # 3.8.0
  ## fonts
  fira-code            # 6.2
  ## misc
  peridot              # 0.1.1
  ## nix
  cachix               # 1.7
  # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
  glibcLocales         # 2.39-5
  ## qutebrowser
  asciidoc             # 10.2.0
  bitwarden-cli        # 2024.3.1
  ## rust
  rustup               # 1.26.0
  ## shell
  fish                 # 3.7.1
  ## verification
  coq_8_17             # 8.17.1
  dafny                # 4.6.0
  ## vim
  coq-ctags            # 0.0.0
  solidity-ctags       # 0.0.2
  universal-ctags      # 6.1.0
  vim                  # 9.1.0346
  ## xmonad
  dmenu                # 5.3
  xmobar               # 0.47.4
  xmonad-with-packages # 9.6.4
]
