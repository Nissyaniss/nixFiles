{ ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "${./wallpapers/chiyoda.png}"
      ];
      wallpaper = [
        # By display
        # {
        #   monitor = "DP-2";
        #   path = "~/wallpapers/wallpaper2.jpg";
        # }
        # By default/fallback
        {
          monitor = "";
          path = "${./wallpapers/chiyoda.png}";
        }
      ];
    };
  };
}
