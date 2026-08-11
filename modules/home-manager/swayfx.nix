{ config, lib, ... }:
let
  cfg = config.local.swayfx;

  animationsType = lib.types.submodule {
    options = {
      duration_ms = lib.mkOption {
        type = lib.types.ints.between 0 5000;
        default = 250;
      };
    };
  };

  blurType = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      xray = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      passes = lib.mkOption {
        type = lib.types.ints.between 0 10;
        default = 4;
      };

      radius = lib.mkOption {
        type = lib.types.ints.between 0 10;
        default = 4;
      };

      noise = lib.mkOption {
        type = lib.types.addCheck lib.types.float (n: n >= 0.0 && n <= 1.0);
      };

      brightness = lib.mkOption {
        type = lib.types.addCheck lib.types.float (n: n >= 0.0 && n <= 2.0);
      };

      contrast = lib.mkOption {
        type = lib.types.addCheck lib.types.float (n: n >= 0.0 && n <= 2.0);
      };

      saturation = lib.mkOption {
        type = lib.types.addCheck lib.types.float (n: n >= 0.0 && n <= 2.0);
      };
    };
  };

  shadowType = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
      };

      on_csd = {
        type = lib.types.bool;
        default = false;
      };

      blur_radius = {
        type = lib.types.ints.between 0 99;
      };

      color = {
        type = lib.types.str;
        default = "#0000007F";
      };
    };
  };

  layer_effects = lib.types.submodule {
    options = {
      app_name = lib.mkOption {
        type = lib.types.str;
      };

      blur = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
          };

          xray = lib.mkOption {
            type = lib.types.bool;
          };

          ignore_transparent = lib.mkOption {
            type = lib.types.bool;
          };
        };
      };

      shadows = lib.mkOption {
        type = lib.types.bool;
      };

      corner_radius = lib.mkOption {
        type = lib.types.int;
      };
    };
  };

  monitorType = lib.types.submodule {
    options = {
      monitor_name = lib.mkOption {
        type = lib.types.str;
      };

      resolution = lib.mkOption {
        type = lib.types.str;
      };

      position = lib.types.submodule {
        options = {
          x = lib.mkOption {
            type = lib.types.int;
          };
          y = lib.mkOption {
            type = lib.types.int;
          };
        };
      };
    };
  };

  touchPadType = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
      };
      tap = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      natural_scroll = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      dwt = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  keyboardType = lib.types.submodule {
    options = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "us";
      };
    };
  };

  gapsType = lib.types.submodule {
    options = {
      inner = lib.mkOption {
        type = lib.types.int;
        default = 8;
      };
      outer = lib.mkOption {
        type = lib.types.int;
        default = 4;
      };
      smart_gaps = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
in
{
  options.local.swayfx = {
    enable = lib.mkEnableOption "Enable SwayFX";

    animations = lib.mkOption {
      type = animationsType;
    };

    blur = lib.mkOption {
      type = blurType;
    };

    corner_radius = lib.mkOption {
      type = lib.types.int;
    };

    shadow = lib.mkOption {
      type = shadowType;
    };

    layer_effects = lib.mkOption {
      type = lib.types.listOf layer_effects;
      default = [ ];
    };

    vars = lib.mkOption {
      type = lib.types.attrs lib.types.str;
    };

    monitor = lib.mkOption {
      type = monitorType;
    };

    keyboard = lib.mkOption {
      type = keyboardType;
    };

    touchPad = lib.mkOption {
      type = touchPadType;
    };

    gaps = lib.mkOption {
      type = gapsType;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      inherit (cfg) enable;
      settings = {
        inherit (cfg) exec-once;

        "debug:disable_logs" = cfg.enable_logs;

        inherit (cfg) env;

        inherit (cfg) input;

        inherit (cfg) general;

        inherit (cfg) decoration;

        inherit (cfg) animations;

        inherit (cfg) dwindle;

        inherit (cfg) misc;

        inherit (cfg) bindm;

        inherit (cfg) bind;

        monitorv2 = cfg.monitors;
      };
    };
  };
}
