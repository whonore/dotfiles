{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.universal-ctags;
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

  config = let
    pluginCfg =
      concatStringsSep "\n"
      (map (plug: "--options=${plug}/share/ctags.d/optlib") cfg.plugins);
  in
    mkIf cfg.enable {
      home.packages = [pkgs.universal-ctags] ++ cfg.plugins;
      xdg.configFile."ctags/config.ctags".text =
        ''
          ${pluginCfg}
        ''
        + cfg.extraConfig;
    };
}
