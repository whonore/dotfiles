{pkgs, ...}: {
  home.packages = import ./packages.nix pkgs;

  programs.home-manager.enable = true;
}
