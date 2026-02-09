{ lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    types
    literalExpression

    optionalAttrs
    filterAttrs
    concatMapAttrs
    unique
    mapAttrsToList
    ;

  defWindowOptions = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          example = "statusbar";
          descritption = ''
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
          descritpion = ''
            X position of the window
          '';
        };
        geometry.y = mkOption {
          type = types.str;
          example = "50px";
          descritpion = ''
            Y position of the window
          '';
        };
        geometry.width = mkOption {
          type = types.str;
          example = "40px or 100%";
          descritpion = ''
            Width of the window
          '';
        };
        geometry.height = mkOption {
          type = types.str;
          example = "40px or 100%";
          descritpion = ''
            Height of the window
          '';
        };
        geometry.anchor = mkOption {
          type = types.str;
          example = "top center";
          descritpion = ''
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
          type = types.bool;
          example = "eww";
          description = ''
            Honestly no idea
          '';
        };
      };
    }
  );

  defListenOptions = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          example = "workspaces";
          descritption = ''
            Name of the listener.
          '';
        };
        command = mkOption {
          type = types.str;
          example = "python workspaces.py";
          descritption = ''
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

  defVarOptions = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          example = "mpris-hidden";
          descritption = ''
            Name of the var.
          '';
        };
        value = mkOption {
          type = types.str;
          example = "true";
          descritption = ''
            Value of the var.
          '';
        };
      };
    }
  );

  defPollOptions = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          example = "dateName";
          descritption = ''
            Name of the poll.
          '';
        };
        interval = mkOption {
          type = types.str;
          example = "1s";
          descritption = ''
            Interval in wich the poll command is called.
          '';
        };
        command = mkOption {
          type = types.str;
          example = "date +%T";
          descritption = ''
            Command that is called at poll interval.
          '';
        };
      };
    }
  );

  defWidget = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = types.str;
          example = "statusbar";
          descritption = ''
            Name of the widget.
          '';
        };
        children = {
          type = children;
        };
      };
    }
  );

  widgetDefaultAttributes =
    {
      class = mkOption {
        type = types.str;
        example = "good-lookin-class";
        descritption = ''
          Css class name.
        '';
      };
      valign = mkOption {
        type = types.str;
        example = "fill";
        descritption = ''
          How to align this vertically. possible values: "fill", "baseline", "center", "start", "end".
        '';
      };
      halign = mkOption {
        type = types.str;
        example = "fill";
        descritption = ''
          How to align this horizontally. possible values: "fill", "baseline", "center", "start", "end"
        '';
      };
      vexpand = mkOption {
        type = types.nullOr types.bool;
        default = false;
        example = "fill";
        descritption = ''
          Should this container expand vertically.
        '';
      };
      hexpand = mkOption {
        type = types.nullOr types.bool;
        default = false;
        descritption = ''
          Should this widget expand horizontally.
        '';
      };
      width = mkOption {
        type = types.int;
        descritption = ''
          Should this widget expand horizontally.
        '';
      };
      # width: int width of this element. note that this can not restrict the size if the contents stretch it
      # height: int height of this element. note that this can not restrict the size if the contents stretch it
      # active: bool If this widget can be interacted with
      # tooltip: string tooltip text (on hover)
      # visible: bool visibility of the widget
      # style: string inline scss style applied to the widget
      # css: string scss code applied to the widget, i.e.: button {color: red;}

    };

  children = types.oneOf [
    centerBox
  ];

  centerBox = types.submodule (
    { ... }:
    {
      options = {
        class = mkOption {
          type = types.str;
          example = "centerbox";
          descritption = ''
            Class of the centerbox.
          '';
        };
        orientation = mkOption {
          type = types.str;
          example = "horizontal";
          descritption = ''
            Orientation of the centerbox.
          '';
        };
        children = {
          type = types.attrsOf children;
          example = "coming soon";
          descritption = ''
            List of childrens.
          '';
        };
      };
    }
  );

  box = types.submodule (
    { ... }:
    {
      options = {
        space-evenly = mkOption {
          type = types.bool;
          descritption = ''
            Whether 
          '';
        };
        orientation = mkOption {
          type = types.str;
          example = "horizontal";
          descritption = ''
            Orientation of the centerbox.
          '';
        };
        children = {
          type = types.attrsOf children;
          example = "coming soon";
          descritption = ''
            List of childrens.
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
      type = with types; attrsOf defVarOptions;
      example = ''
          defVar = [
        {
        name = "workspace";
        value = "true";
        }
        ]
      '';
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
  };
}

