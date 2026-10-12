_: {
  stylix.targets.swaync.enable = false;
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      layer = "top";
      control-center-layer = "top";
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      keyboard-shortcuts = true;
      image-visibility = "always";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 0;
      control-center-width = 600;
      control-center-height = 600;
      notification-window-width = 500;
      notification-visibility = {
        Cider = {
          state = "muted";
          urgency = "Low";
          app-name = "Cider";
        };
        cider = {
          state = "muted";
          urgency = "Low";
          app-name = "cider";
        };
        Cider2 = {
          state = "muted";
          urgency = "Low";
          app-name = "Cider2";
        };
        cider2 = {
          state = "muted";
          urgency = "Low";
          app-name = "cider2";
        };
      };
      "widgets" = [
        "menubar"
        "dnd"
        "notifications"
        "mpris"
      ];
      widget-config = {
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };
    style = ./style.css;
  };
}
