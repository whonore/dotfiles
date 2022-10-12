{
  pkgs,
  system,
}: let
  missing-platforms = {
    "${pkgs.xmonad-with-packages.name}" = pkgs.lib.platforms.linux;
  };
  platforms = pkg: let
    good = pkgs.lib.attrByPath ["meta" "platforms"] (builtins.getAttr pkg.name missing-platforms) pkg;
    bad = pkgs.lib.attrByPath ["meta" "badPlatforms"] [] pkg;
  in
    builtins.filter (sys: !(builtins.elem sys bad)) good;
  supportsSys = sys: system.canExecute (pkgs.lib.systems.elaborate sys);
  supports = pkg: pkgs.lib.isAttrs pkg && builtins.any supportsSys (platforms pkg);
in
  with pkgs;
    builtins.filter supports
    [
      ## app
      drawio               # 20.2.3
      ## cli
      bat                  # 0.22.0
      clang-tools          # 14.0.6
      delta                # 0.14.0
      exa                  # 0.10.1
      fd                   # 8.4.0
      fzf                  # 0.33.0
      ripgrep              # 13.0.0
      rlwrap               # 0.45.2
      rm-improved          # 0.13.0
      xclip                # 0.13
      zoxide               # 0.8.3
      ## coq
      coq_8_15             # 8.15.2
      ## fmt
      alejandra            # 3.0.0+20220815.91d4a0b
      bibclean             # 3.06
      cppcheck             # 2.9
      nixfmt               # 0.5.0
      shellcheck           # 0.8.0
      shfmt                # 3.5.1
      ## fonts
      fira-code            # 6.2
      ## misc
      bitwise              # 0.43
      openconnect          # 9.01
      peridot              # 0.1.1
      ## nix
      cachix               # 0.8.1
      # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
      glibcLocales         # 2.35-163
      ## qutebrowser
      asciidoc             # 10.2.0
      lastpass-cli         # 1.3.3
      ## rust
      rust-analyzer        # 2022-08-22
      rustup               # 1.25.1
      ## shell
      fish                 # 3.5.1
      pash                 # 0.7
      ## vim
      coq-ctags            # 0.0
      universal-ctags      # 5.9.20220814.0
      vim                  # 9.0.0399
      ## xmonad
      dmenu                # 5.1
      xmobar               # 0.44.2
      xmonad-with-packages # 9.0.2
    ]
