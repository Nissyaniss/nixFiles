{ lib
, cfg
, config
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    ;
  hyprlandDefaultSettings = import ../config/hyprland/settings.nix;
  monitorOptions = types.submodule
    (
      { ... }:
      {
        options = {
          output = mkOption {
            type = types.str;
            description = ''
            '';
          };
          mode = mkOption {
            type = types.str;
            description = ''
            '';
          };
          position = mkOption {
            type = types.str;
            descritption = ''
            '';
          };
          scale = mkOption {
            type = types.int;
            descritption = ''
            '';
          };
        };
      }
    );
in
{
  options.hyprland =
    {
      enable = mkEnableOption "Enable Hyprland";
      monitor = types.listOf monitorOptions;
    };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.settings = hyprlandDefaultSettings // {
      monitorv2 = config.hyprland.monitor;
    };
  };
}
