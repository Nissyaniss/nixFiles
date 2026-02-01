{
  settings = {
    monitorv2 = [
      {
        output = "DP-2";
        mode = "2560x1440@144";
        position = "0x0";
        scale = 1;
      }
      {
        output = "HDMI-A-1";
        mode = "1360x768@60";
        position = "2560x672";
        scale = 1;
      }
    ];
    exec-once = [
      "eww open statusbar && legcord"
      "elephant"
    ];

    "debug:diable_logs" = true; # false to have logs

    cursor = {
      no_hardware_cursors = true;
    };

    env = [
      "XCURSOR_SIZE,24"
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];

    input =
      {

        # See https://wiki.hyprland.org/Configuring/Variables
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        numlock_by_default = true;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
        };

        sensitivity = 0;
      };

    general =
      {

        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        col.inactive_border = "rgba(595959aa)";

        layout = "dwindle";

        allow_tearing = false;
      };


    decoration =
      {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;
      };

    animations = {
      enabled = "yes";

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = "yes";
      preserve_split = "yes";
    };

    misc =
      {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };
  };
}
