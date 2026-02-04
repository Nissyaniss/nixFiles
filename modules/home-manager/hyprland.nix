{ lib
, config
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;
  hyprlandDefaultSettings = import ../../config/home-manager/hyprland/settings.nix { };
  monitorOptions = types.submodule
    (
      { ... }:
      {
        options = {
          output = mkOption {
            type = types.str;
            description = ''
              Name of the monitor. (using hyprctl monitors to get)
            '';
          };
          mode = mkOption {
            type = types.str;
            description = ''
              XxY@hz where X and Y are the sizes of your screen (for example 1920x1080 is X = 1920 and Y = 1080) and hz the number of hertz for your screen (hyprctl monitors to know what is the supported hz for your monitors)
            '';
          };
          position = mkOption {
            type = types.str;
            description = ''
              XxY where X and Y are the position in pixels of the screens.
            '';
          };
          scale = mkOption {
            type = types.int;
            description = ''
              Scale of your screens
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
      monitor = mkOption { type = types.listOf monitorOptions; };
    };
  config = mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = hyprlandDefaultSettings // { monitorv2 = config.hyprland.monitor; };
    };
  };
}
