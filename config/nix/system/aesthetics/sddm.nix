{ pkgs
, lib
, machine-name
, ...
}:
let
  extraSddmSettingsPc =
    if machine-name == "pc" then {
      setupScript = ''
        ${pkgs.xrandr}/bin/xrandr --output DP-2 --primary --mode 2560x1440 --rate 144 --rotate normal --output HDMI-1 --off
      '';
    } else { };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    theme = "sddm-astronaut-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
    settings = {
      General = { InputMethod = ""; };
    };
  } // extraSddmSettingsPc;
  systemd.services.display-manager.environment = {
    QT_IM_MODULE = lib.mkForce "none";
    QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = lib.mkForce "1";
  };
  services.xserver.enable = true;
}
