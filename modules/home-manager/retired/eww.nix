{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    types
    ;

  jsonFormat = pkgs.formats.json { };

  defWindowOptions = types.submodule (
    { name, ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          default = name;
          description = ''
            Name of the window.
          '';
        };
        monitor = mkOption {
          type = types.int;
          example = 0;
          description = ''
            The monitor where the widget appears.
          '';
        };
        geometry.x = mkOption {
          type = types.str;
          example = "50px";
          description = ''
            X position of the window
          '';
        };
        geometry.y = mkOption {
          type = types.str;
          example = "50px";
          description = ''
            Y position of the window
          '';
        };
        geometry.width = mkOption {
          type = types.str;
          example = "40px or 100%";
          description = ''
            Width of the window
          '';
        };
        geometry.height = mkOption {
          type = types.str;
          example = "40px or 100%";
          description = ''
            Height of the window
          '';
        };
        geometry.anchor = mkOption {
          type = types.str;
          example = "top center";
          description = ''
            Anchor of the window
          '';
        };
        stacking = mkOption {
          type = types.str;
          example = "fg";
          description = ''
            Where the window is placed in the stack 
          '';
        };
        exclusive = mkOption {
          type = types.bool;
          description = ''
            Honestly no idea
          '';
        };
        focusable = mkOption {
          type = types.bool;
          description = ''
            Whether the window is focusable
          '';
        };
        namespace = mkOption {
          type = types.str;
          example = "eww";
          description = ''
            Honestly no idea
          '';
        };
      };
    }
  );

  defListenOptions = types.submodule (
    { name, ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          default = name;
          example = "workspaces";
          description = ''
            Name of the listener.
          '';
        };
        command = mkOption {
          type = types.str;
          example = "python workspaces.py";
          description = ''
            Command to listen.
          '';
        };
        initial = mkOption {
          type = with types; nullOr jsonFormat.type;
          default = null;
          example = ''
            # needs the double {} (i think)
            initial = {
              {
                value = "wow"
              }
            };
          '';
          description = ''
            Initial value
          '';
        };
      };
    }
  );

  defPollOptions = types.submodule (
    { name, ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          default = name;
          description = ''
            Name of the poll.
          '';
        };
        interval = mkOption {
          type = types.str;
          example = "1s";
          description = ''
            Interval in wich the poll command is called.
          '';
        };
        command = mkOption {
          type = types.str;
          example = "date +%T";
          description = ''
            Command that is called at poll interval.
          '';
        };
      };
    }
  );

in
{
  options.eww = {
    enable = mkEnableOption "eww";
    package = mkPackageOption pkgs "eww" { };

    defWindow = mkOption {
      type = with types; attrsOf defWindowOptions;
      example = ''
              defWindow = [
          {
          name = "statusbar";
          monitor = 0;
          geometry = {
            x = "0px";
            y = "0px";
            width = "100%";
            height = "40px";
            anchor = "top center";
          };
          stacking = "fg";
          exclusive = true;
          focusable = false;
          namespace = "eww";
        }
        ];
      '';
    };

    defListen = mkOption {
      type = with types; attrsOf defListenOptions;
      example = ''
          defListen = [
          {
            name = "mpris-hidden";
            command = "python workspaces.py";
          }
        ]
      '';
    };

    defVar = mkOption {
      type = types.attrsOf types.str;
    };

    defPoll = mkOption {
      type = with types; attrsOf defPollOptions;
      example = ''
        defPoll = [
          {
            name = dateHour;
            interval = "1s"
              command = "date +%T"
            }
            ];
      '';
    };

    defWidget = mkOption {
      type = types.str;
    };

    scssPath = mkOption {
      type = types.path;
    };
  };

  config = {
    home.packages = [ config.eww.package ];
    xdg.configFile = {
      "eww/eww.yuck".text = ''
        ${lib.concatMapAttrsStringSep "\n" (name: defWindow: ''
          (defwindow ${name}
            :monitor ${toString defWindow.monitor}
            :geometry (geometry
                :x "${defWindow.geometry.x}"
                :y "${defWindow.geometry.y}"
                :width "${defWindow.geometry.width}"
                :height "${defWindow.geometry.height}"
                :anchor "${defWindow.geometry.anchor}"
              )
            :stacking "${defWindow.stacking}"
            :exclusive ${if defWindow.exclusive then "true" else "false"}
            :focusable ${if defWindow.focusable then "true" else "false"}
            :namespace "${defWindow.namespace}"

            (${name})
          )
        '') config.eww.defWindow}
        ${lib.concatMapAttrsStringSep "\n" (name: defListen: ''
          (deflisten ${name}
            ${
              lib.optionalString (defListen.initial != null) ":initial '${lib.toJSON defListen.initial}'\n  "
            }"${defListen.command}"
          )
        '') config.eww.defListen}
        ${lib.concatMapAttrsStringSep "\n" (name: value: ''
          (defvar ${name} ${value})
        '') config.eww.defVar}
        ${lib.concatMapAttrsStringSep "\n" (name: defPoll: ''
          (defpoll ${name}
            :interval "${defPoll.interval}"
            `${defPoll.command}`
          )
        '') config.eww.defPoll}
        ${config.eww.defWidget}
      '';
      "eww/eww.scss".source = config.eww.scssPath;
    };
  };
}
