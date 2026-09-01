_: {
  security.sudo-rs.enable = true;
  programs.zsh.enable = true;
  virtualisation.docker.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
  };
  programs.hyprland = {
    withUWSM = false;
    enable = true;
  };
  programs.kdeconnect.enable = true;
  security.pam.services.quickshell = { };
}
