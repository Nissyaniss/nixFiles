{ ... }: {
  programs.zsh.enable = true;
  virtualisation.docker.enable = true;
  programs.steam.enable = true;
  services.flatpak.enable = true; # why ?
  services.gvfs.enable = true;
  services.ratbagd.enable = true;
  services.transmission.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
}
