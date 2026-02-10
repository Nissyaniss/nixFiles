{ lib
, pkgs
, config
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    types
    ;

  ewwConfigFile = "eww/eww.yuck";
  ewwScssFile = "eww/eww.scss";

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

  # defListenOptions = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       name = mkOption {
  #         type = types.str;
  #         example = "workspaces";
  #         description = ''
  #           Name of the listener.
  #         '';
  #       };
  #       command = mkOption {
  #         type = types.str;
  #         example = "python workspaces.py";
  #         description = ''
  #           Command to listen.
  #         '';
  #       };
  #       initial = mkOption {
  #         type = with types; nullOr jsonFormat.type;
  #         default = null;
  #         example = ''
  #           # needs the double {} (i think)
  #           initial = {
  #             {
  #               value = "wow"
  #             }
  #           };
  #         '';
  #         description = ''
  #           Initial value
  #         '';
  #       };
  #     };
  #   }
  # );

  # defVarOptions = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       name = mkOption {
  #         type = types.str;
  #         example = "mpris-hidden";
  #         description = ''
  #           Name of the var.
  #         '';
  #       };
  #       value = mkOption {
  #         type = types.str;
  #         example = "true";
  #         description = ''
  #           Value of the var.
  #         '';
  #       };
  #     };
  #   }
  # );

  # defPollOptions = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       name = mkOption {
  #         type = types.str;
  #         example = "dateName";
  #         description = ''
  #           Name of the poll.
  #         '';
  #       };
  #       interval = mkOption {
  #         type = types.str;
  #         example = "1s";
  #         description = ''
  #           Interval in wich the poll command is called.
  #         '';
  #       };
  #       command = mkOption {
  #         type = types.str;
  #         example = "date +%T";
  #         description = ''
  #           Command that is called at poll interval.
  #         '';
  #       };
  #     };
  #   }
  # );

  # defWidgetOptions = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       name = mkOption {
  #         type = types.str;
  #         example = "statusbar";
  #         description = ''
  #           Name of the widget.
  #         '';
  #       };
  #       children = {
  #         type = children;
  #         description = ''
  #           Children of the widget.
  #         '';
  #       };
  #     };
  #   }
  # );

  # widgetDefaultAttributes =
  #   {
  #     class = mkOption {
  #       type = types.str;
  #       example = "good-lookin-class";
  #       description = ''
  #         Css class name.
  #       '';
  #     };
  #     valign = mkOption {
  #       type = types.str;
  #       example = "fill";
  #       description = ''
  #         How to align this vertically. possible values: "fill", "baseline", "center", "start", "end".
  #       '';
  #     };
  #     halign = mkOption {
  #       type = types.str;
  #       example = "fill";
  #       description = ''
  #         How to align this horizontally. possible values: "fill", "baseline", "center", "start", "end"
  #       '';
  #     };
  #     vexpand = mkOption {
  #       type = types.bool;
  #       default = false;
  #       example = "fill";
  #       description = ''
  #         Should this container expand vertically.
  #       '';
  #     };
  #     hexpand = mkOption {
  #       type = types.bool;
  #       default = false;
  #       description = ''
  #         Should this widget expand horizontally.
  #       '';
  #     };
  #     width = mkOption {
  #       type = types.int;
  #       description = ''
  #         Width of this element. note that this can not restrict the size if the contents stretch it.
  #       '';
  #     };
  #     height = mkOption {
  #       type = types.int;
  #       description = ''
  #         Height of this element. note that this can not restrict the size if the contents stretch it.
  #       '';
  #     };
  #     active = mkOption {
  #       type = types.bool;
  #       default = true;
  #       description = ''
  #         If this widget can be interacted with.
  #       '';
  #     };
  #     tooltip = mkOption {
  #       type = types.str;
  #       default = "";
  #       description = ''
  #         Tooltip text (on hover)
  #       '';
  #     };
  #     visible = mkOption {
  #       type = types.bool;
  #       default = true;
  #       description = ''
  #         Visibility of the widget
  #       '';
  #     };
  #     style = mkOption {
  #       type = types.lines;
  #       default = "";
  #       description = ''
  #         Inline scss style applied to the widget
  #       '';
  #     };
  #     css = mkOption {
  #       type = types.lines;
  #       default = "";
  #       description = ''
  #         Scss code applied to the widget.
  #       '';
  #     };
  #   };

  # children = types.oneOf [
  #   centerBox
  #   box
  #   button
  #   label
  #   systray
  # ];

  # centerBox = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       orientation = mkOption {
  #         type = types.str;
  #         example = "horizontal";
  #         description = ''
  #           Orientation of the centerbox.
  #         '';
  #       };
  #       children = {
  #         type = types.attrsOf children;
  #         example = "coming soon";
  #         description = ''
  #           List of childrens.
  #         '';
  #       };
  #     } // widgetDefaultAttributes;
  #   }
  # );

  # box = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       space-evenly = mkOption {
  #         type = types.bool;
  #         description = ''
  #           Whether 
  #         '';
  #       };
  #       orientation = mkOption {
  #         type = types.str;
  #         example = "horizontal";
  #         description = ''
  #           Orientation of the centerbox.
  #         '';
  #       };
  #       spacing = {
  #         type = types.int;
  #         example = "coming soon";
  #         description = ''
  #           Spacing between elements.
  #         '';
  #       };
  #       children = {
  #         type = types.attrsOf children;
  #         example = "coming soon";
  #         description = ''
  #           List of childrens.
  #         '';
  #       };
  #     } // widgetDefaultAttributes;
  #   }
  # );

  # button = types.submodule (
  #   { ... }:
  #   {
  #     options = {
  #       timeout = {
  #         type = types.str;
  #         default = "200ms";
  #         description = ''
  #           Duration timeout of the command.
  #         '';
  #       };
  #       onclick = {
  #         type = types.str;
  #         description = ''
  #           Command to run when the button is activated either by leftclicking or keyboard.
  #         '';
  #       };
  #       onmiddleclick = {
  #         type = types.str;
  #         description = ''
  #           Command to run when the button is middleclicked.
  #         '';
  #       };
  #       onrightclick = {
  #         type = types.str;
  #         description = ''
  #           Command to run when the button is rightclicked.
  #         '';
  #       };
  #     } // widgetDefaultAttributes;
  #   }
  # );

  # label = types.submodule (
  #   { ... }: {
  #     options = {
  #       text = {
  #         type = types.str;
  #         description = ''
  #           The text to display.
  #         '';
  #       };
  #       truncate = {
  #         type = types.nullOr types.bool;
  #         default = false;
  #         description = ''
  #           Whether to truncate text (or pango markup). If show-truncated is false, or if limit-width has a value, this property has no effect and truncation is enabled.
  #         '';
  #       };
  #       limit-width = {
  #         type = types.nullOr types.int;
  #         default = null;
  #         description = ''
  #           Maximum count of characters to display.
  #         '';
  #       };
  #       truncate-left = {
  #         type = types.bool;
  #         default = false;
  #         description = ''
  #           Whether to truncate on the left side.
  #         '';
  #       };
  #       show-truncated = {
  #         type = types.bool;
  #         default = false;
  #         description = ''
  #           Show whether the text was truncated. Disabling it will also disable dynamic truncation (the labels won't be truncated more than limit-width, even if there is not enough space for them), and will completly disable truncation on pango markup.
  #         '';
  #       };
  #       unindent = {
  #         type = types.bool;
  #         default = true;
  #         description = ''
  #           Whether to remove leading spaces.
  #         '';
  #       };
  #       markup = {
  #         type = types.nullOr types.str;
  #         default = null;
  #         description = ''
  #           Pango markup to display.
  #         '';
  #       };
  #       wrap = {
  #         type = types.bool;
  #         default = false;
  #         description = ''
  #           Wrap the text. This mainly makes sense if you set the width of this widget.
  #         '';
  #       };
  #       angle = {
  #         type = types.ints.between 0 360;
  #         default = 0;
  #         description = ''
  #           The angle of rotation for the label (between 0 - 360).
  #         '';
  #       };
  #       gravity = {
  #         type = types.nullOr types.str;
  #         default = null;
  #         description = ''
  #           The gravity of the string (south, east, west, north, auto). Text will want to face the direction of gravity.
  #         '';
  #       };
  #       xalign = {
  #         type = types.nullOr types.ints.between 0 1;
  #         default = null;
  #         description = ''
  #           The alignment of the label text on the x axis (between 0 - 1, 0 -> bottom, 0.5 -> center, 1 -> top).
  #         '';
  #       };
  #       yalign = {
  #         type = types.nullOr types.ints.between 0 1;
  #         default = null;
  #         description = ''
  #           The alignment of the label text on the y axis (between 0 - 1, 0 -> bottom, 0.5 -> center, 1 -> top).
  #         '';
  #       };
  #       justify = {
  #         type = types.nullOr types.str;
  #         default = null;
  #         description = ''
  #           The justification of the label text (left, right, center, fill).
  #         '';
  #       };
  #       wrap-mode = {
  #         type = types.nullOr types.str;
  #         default = null;
  #         description = ''
  #           How text is wrapped. possible options: "word", "char", "wordchar".
  #         '';
  #       };
  #       lines = {
  #         type = types.int;
  #         default = -1;
  #         description = ''
  #           Maximum number of lines to display (only works when limit-width has a value). A value of -1 (default) disables the limit.
  #         '';
  #       };
  #     } // widgetDefaultAttributes;
  #   }
  # );

  # systray = types.submodule (
  #   { ... }: {
  #     options = {
  #       spacing = {
  #         type = types.nullOr types.int;
  #         default = null;
  #         description = ''
  #           Spacing between elements.
  #         '';
  #       };
  #       orientation = {
  #         type = types.nullOr types.str;
  #         default = null;
  #         description = ''
  #           Orientation of the box. possible values: "vertical", "v", "horizontal", "h".
  #         '';
  #       };
  #       space-evenly = {
  #         type = types.bool;
  #         default = false;
  #         description = ''
  #           Space the widgets evenly.
  #         '';
  #       };
  #       icon-size = {
  #         type = types.nullOr types.positive;
  #         default = null;
  #         description = ''
  #           Size of icons in the tray.
  #         '';
  #       };
  #       prepend-new = {
  #         type = types.bool;
  #         default = true;
  #         description = ''
  #           Prepend new icons.
  #         '';
  #       };
  #     } // widgetDefaultAttributes;
  #   }
  # );
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

    # defListen = mkOption {
    #   type = with types; attrsOf defListenOptions;
    #   example = ''
    #       defListen = [
    #       {
    #         name = "mpris-hidden";
    #         command = "python workspaces.py";
    #       }
    #     ]
    #   '';
    # };

    # defVar = mkOption {
    #   type = with types; attrsOf defVarOptions;
    #   example = ''
    #       defVar = [
    #     {
    #     name = "workspace";
    #     value = "true";
    #     }
    #     ]
    #   '';
    # };
    # defPoll = mkOption {
    #   type = with types; attrsOf defPollOptions;
    #   example = ''
    #     defPoll = [
    #       {
    #         name = dateHour;
    #         interval = "1s"
    #           command = "date +%T"
    #         }
    #         ];
    #   '';
    # };

    # defWidget = mkOption {
    #   type = with types; attrsOf defWidgetOptions;
    # };
  };

  config = {
    home.packages = [ config.eww.package ];
    xdg.configFile = {
      ewwConfigFile.text = ''
        ${lib.concatMapAttrsStringSep "\n" (name: defWindow:
          ''
          (defwindow ${name}
            :monitor ${toString defWindow.monitor}
              :geometry (geometry
                :x ${defWindow.geometry.x}
                :y ${defWindow.geometry.y}
                :width ${defWindow.geometry.width}
                :height ${defWindow.geometry.height}
                :anchor ${defWindow.geometry.anchor}
              )
            :stacking ${defWindow.stacking}
            :exclusive ${toString defWindow.exclusive}
            :focusable ${toString defWindow.focusable}
            :namespace ${defWindow.namespace}
          )

          (${name})
          ''
          )
          config.eww.defWindow}
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
