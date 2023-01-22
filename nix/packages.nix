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
      drawio               # 20.7.4
      ## cli
      bat                  # 0.22.1
      clang-tools          # 14.0.6
      delta                # 0.15.1
      exa                  # 0.10.1
      fd                   # 8.6.0
      fzf                  # 0.35.1
      ripgrep              # 13.0.0
      rlwrap               # 0.46
      rm-improved          # 0.13.0
      xclip                # 0.13
      zoxide               # 0.8.3
      ## coq
      coq_8_15             # 8.15.2
      ## fmt
      alejandra            # 3.0.0+20221113.378cde9
      bibclean             # 3.06
      cppcheck             # 2.9.3
      nixfmt               # 0.5.0
      shellcheck           # 0.9.0
      shfmt                # 3.6.0
      ## fonts
      fira-code            # 6.2
      ## misc
      bitwise              # 0.43
      openconnect          # 9.01
      peridot              # 0.1.1
      ## nix
      cachix               # 1.1
      # NOTE: see https://github.com/NixOS/nixpkgs/issues/38991
      glibcLocales         # 2.35-224
      ## qutebrowser
      asciidoc             # 10.2.0
      lastpass-cli         # 1.3.3
      ## rust
      rust-analyzer        # 2022-12-26
      rustup               # 1.25.1
      ## shell
      fish                 # 3.5.1
      ## vim
      coq-ctags            # 0.0.0
      universal-ctags      # 5.9.20221106.0
      vim                  # 9.0.0915
      ## xmonad
      dmenu                # 5.2
      xmobar               # 0.45
      xmonad-with-packages # 9.2.4
    ]
