{
  pkgs,
  system,
  ...
}: {
  home.packages = import ./packages.nix {inherit pkgs system;};
  imports = [
    ./modules/universal-ctags.nix
  ];

  programs.home-manager.enable = true;

  programs.universal-ctags = {
    enable = true;
    plugins = [pkgs.coq-ctags];
  };
}
