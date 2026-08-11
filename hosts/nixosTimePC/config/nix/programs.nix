{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraOptions = [ "--unsupported-gpu" ];
  };
  programs.hyprland.enable = true;
  programs.steam.enable = true;
  services.gvfs.enable = true;
  services.ratbagd.enable = true;
  services.transmission.enable = true;
}
