{ pkgs
, lib
, ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = false;
    };
    theme = "sddm-black_hole-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
    setupScript = ''
      export QT_IM_MODULE=""
      export QT_VIRTUAL_KEYBOARD_STYLE=""
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --primary --mode 2560x1440 --rate 144 --rotate normal --output HDMI-1 --off
    '';

    settings = {
      General = { InputMethod = ""; };
    };
  };
  systemd.services.display-manager.environment = {
    QT_IM_MODULE = lib.mkForce "none";
    QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = lib.mkForce "1";
  };
  services.xserver.enable = true;
}
