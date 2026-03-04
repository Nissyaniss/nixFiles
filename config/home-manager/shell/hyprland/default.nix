{ machine-name
, lib
, ...
}:
let
  bindConf = import ./keymaps/bind.nix;
  bindmConf = import ./keymaps/bindm.nix;
  monitorConf =
    if machine-name == "pc" then {
      monitorv2 = [
        {
          output = "DP-2";
          mode = "modeline 798.86 2560 2568 2592 2672 1440 1463 1471 1492 +hsync -vsync";
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
    } else if machine-name == "work" then {
      monitorv2 = [
        {
          output = "eDP-1";
          mode = "1920x1080@60Hz";
          position = "0x0";
          scale = 1;
        }
        {
          output = "DP-4";
          mode = "1920x1080@60Hz";
          position = "1920x0";
          scale = 1;
        }
        {
          output = "DP-5";
          mode = "1920x1080@60Hz";
          position = "-1920x0";
          scale = 1;
        }
      ];
    } else {
      monitorv2 = [
        {
          output = "eDP-1";
          mode = "1920x1080@59.98Hz";
          position = "0x0";
          scale = 1;
        }
      ];
    };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "blueman-applet"
        "legcord"
        "elephant"
        "hyprctl setcursor breeze_cursors 24"
        "wleave --service"
        (lib.optionalString
          (machine-name == "laptop")
          "nvidia-offload linux-wallpaperengine --screen-root eDP-1 1705122927")
      ];

      "debug:disable_logs" = true; # false to have logs

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
          kb_layout = if machine-name == "work" then "fr" else "us";
          kb_variant = if machine-name == "work" then "oss" else "";
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
      bindm = bindmConf;
      bind = bindConf;
    } // monitorConf;
  };
}

