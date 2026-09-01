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

  generalType = lib.types.submodule {
    options = {
      gaps_in = lib.mkOption {
        type = lib.types.int;
        default = 5;
      };

      gaps_out = lib.mkOption {
        type = lib.types.int;
        default = 20;
      };

      border_size = lib.mkOption {
        type = lib.types.int;
        default = 2;
      };
    };
  };

  decorationType = lib.types.submodule {
    options = {
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 10;
      };
    };
  };

  inputType = lib.types.submodule {
    options = {
      kb_layout = lib.mkOption {
        type = lib.types.str;
        default = "us";
      };

      follow_mouse = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      numlock_by_default = lib.mkOption {
        type = lib.types.bool;
        default = true;
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

    config = lib.mkOption {
      type = lib.types.submodule {
        options = {
          general = lib.mkOption {
            type = generalType;
            default = { };
          };
          decoration = lib.mkOption {
            type = decorationType;
            default = { };
          };
          input = lib.mkOption {
            type = inputType;
            default = { };
          };
        };
      };
      default = { };
    };
    binds = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
    };

    exec-once = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    env = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      configType = "lua";
      inherit (cfg) enable;
      settings = {
        monitor = map (monitor: {
          _args = [
            {
              output = monitor.output;
              mode = monitor.mode;
              position = monitor.position;
              scale = monitor.scale;
            }
          ];
        }) cfg.monitors;
        config = {
          inherit (cfg.config) general;
          inherit (cfg.config) decoration;
          input = {
            follow_mouse = if (cfg.config.input.follow_mouse == true) then 1 else 0;
            inherit (cfg.config.input) kb_layout;
            inherit (cfg.config.input) numlock_by_default;
          };
        };
        bind = lib.mapAttrsToList (keybind: dispatcher: {
          _args = [
            keybind
            (lib.generators.mkLuaInline dispatcher)
          ];
        }) cfg.binds;

        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline (
              ''
                function()
              ''
              + lib.concatStringsSep "\n" (
                lib.mapAttrsToList (
                  name: value: "hl.env.set(${builtins.toJSON name}, ${builtins.toJSON value})"
                ) cfg.env
              )
              + "\n"
              + lib.concatMapStringsSep "\n" (program: "hl.exec_cmd(\"${program}\")") cfg.exec-once
              + "\nend"
            ))
          ];
        };
      };
    };
  };
}
