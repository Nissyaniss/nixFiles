{ ... }: {
  services.dunst = {
    enable = true;
    configFile = "${./dunstrc}";
  };
}
