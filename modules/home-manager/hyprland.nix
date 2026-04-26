{ config, lib, ... }:
let
  cfg = config.local.hyprland;

  monitorType = lib.types.submodule {
    options = {
      output = lib.mkOption {
        type = lib.types.str;
        description = "Output name, e.g. DP-2";
      };
      mode = lib.mkOption {
        type = lib.types.str;
        description = "Resolution and refresh rate, e.g. 2560x1440@200";
      };
      position = lib.mkOption {
        type = lib.types.str;
        default = "0x0";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
    };
  };

  inputType = lib.types.submodule {
    options = {
      layout = lib.mkOption {
        type = lib.types.str;
      };
      variant = lib.mkOption {
        type = lib.types.str;
      };
      numlock_by_default = lib.mkOption {
        type = lib.types.bool;
      };
    };
  };

  generalType = lib.types.submodule {
    options = {
      gaps_in = lib.mkOption {
        type = lib.types.int;
      };
      gaps_out = lib.mkOption {
        type = lib.types.int;
      };
      border_size = lib.mkOption {
        type = lib.types.int;
      };
      layout = lib.mkOption {
        type = lib.types.str;
      };
    };
  };

  decorationType = lib.types.submodule {
    options = {
      rounding = lib.mkOption {
        type = lib.types.int;
      };
    };
  };

  animationsType = lib.types.submodule {
    options = {
      enabled = lib.mkOption {
        type = lib.types.bool;
      };

      bezier = lib.mkOption {
        type = lib.types.str;
      };

      animation = lib.mkOption {
        type = lib.types.listOf lib.types.str;
      };
    };
  };

  dwindleType = lib.types.submodule {
    options = {
      pseudotile = lib.mkOption {
        type = lib.types.bool;
      };

      preserve_split = lib.mkOption {
        type = lib.types.bool;
      };
    };
  };

  miscType = lib.types.submodule {
    options = {
      force_default_wallpaper = lib.mkOption {
        type = lib.types.int;
      };

      focus_on_activate = lib.mkOption {
        type = lib.types.bool;
      };
    };
  };
in
{
  options.local.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";
    monitors = lib.mkOption {
      type = lib.types.listOf monitorType;
      default = [ ];
    };

    bind = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    bindm = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    exec-once = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    enable_logs = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    env = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    input = lib.mkOption {
      type = inputType;
      default = {
        layout = "us";
        variant = "";
        numlock_by_default = true;
      };
    };

    general = lib.mkOption {
      type = generalType;
      default = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        layout = "dwindle";
      };
    };

    decoration = lib.mkOption {
      type = decorationType;
      default = {
        rounding = 10;
      };
    };

    animations = lib.mkOption {
      type = animationsType;
      default = {
        enabled = true;

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
    };

    dwindle = lib.mkOption {
      type = dwindleType;
      default = {
        pseudotile = true;
        preserve_split = true;
      };
    };

    misc = lib.mkOption {
      type = miscType;
      default = {
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = cfg.enable;
      settings = {
        exec-once = cfg.exec-once;

        "debug:disable_logs" = cfg.enable_logs;

        env = cfg.env;

        input = cfg.input;

        general = cfg.general;

        decoration = cfg.decoration;

        animations = cfg.animations;

        dwindle = cfg.dwindle;

        misc = cfg.misc;

        bindm = cfg.bindm;

        bind = cfg.bind;

        monitorv2 = cfg.monitors;
      };
    };
  };
}

