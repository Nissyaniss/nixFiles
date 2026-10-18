_: {
  services.udisks2.enable = true;
  services.upower.enable = true;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  programs.hyprland = {
    withUWSM = false;
    enable = true;
  };
  programs.kdeconnect.enable = true;
  security.pam.services.quickshell = { };
}
