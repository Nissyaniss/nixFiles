{ ... }:
{
  local.sddm = {
    enable = true;

    setupScript = [
      {
        monitor = "DP-1";
        resolution = "2560x1440";
        refreshRate = 144;
        primary = true;
      }
      {
        monitor = "HDMI-1";
        deactivate = true;
      }
    ];
  };

  services.displayManager.defaultSession = "hyprland";
}
