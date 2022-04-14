{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.universal-ctags;

  toPluginCfg = plugins:
    concatStringsSep "\n"
    (map (plug: "--options=${plug}/share/ctags.d/optlib") plugins);
in {
  options = {
    programs.universal-ctags = {
      enable = mkEnableOption "Universal ctags";

      plugins = mkOption {
        type = with types; listOf package;
        default = [];
      };

      extraConfig = mkOption {
        default = "";
        type = types.lines;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.universal-ctags] ++ cfg.plugins;
    xdg.configFile."ctags/config.ctags".text =
      toPluginCfg cfg.plugins + cfg.extraConfig;
  };
}
