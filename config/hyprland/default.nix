{ ... }:

let
  hyprlandSettings = import ./settings.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      #...
    ];
    settings = hyprlandSettings;
  };
}
