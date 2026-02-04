{ pkgs
, ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
    theme = "sddm-black_hole-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
  };
}
