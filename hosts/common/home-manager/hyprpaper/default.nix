_: {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "${./wallpapers/chiyoda.png}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "${./wallpapers/chiyoda.png}";
        }
      ];
    };
  };
}
