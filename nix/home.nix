{pkgs, ...}: {
  home.packages = import ./packages.nix pkgs;
  imports = [
    ./modules/universal-ctags.nix
  ];

  programs.home-manager.enable = true;

  programs.universal-ctags = {
    enable = true;
    plugins = [pkgs.coq-ctags];
  };
}
