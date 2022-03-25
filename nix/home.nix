{pkgs, ...}: {
  home.packages = with pkgs; [hello];

  programs.home-manager.enable = true;
}
