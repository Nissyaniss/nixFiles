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
  hyprlandDefaultSettings = import ../../config/hyprland/settings.nix { };
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
            description = ''
            '';
          };
          scale = mkOption {
            type = types.int;
            description = ''
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
