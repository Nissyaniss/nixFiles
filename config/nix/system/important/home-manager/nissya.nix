{ inputs
, pkgs
, ...
}:

{

  imports = [
    inputs.walker.homeManagerModules.default
    ../../../../../modules/home-manager
    ../../../../home-manager
  ];

  home.username = "nissya";
  home.homeDirectory = "/home/nissya";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 24;
  };

  gtk = {
    enable = true;

    cursorTheme = {
      name = "breeze_cursors";
      size = 24;
    };
    iconTheme = {
      package = pkgs.dracula-icon-theme;
      name = "breeze-dark";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = { };

  home.sessionVariables = {
    EDITOR = "subl";
  };

  programs.elephant = {
    enable = true;
    installService = true;
  };

  programs.walker = {
    enable = true;
    runAsService = true;
  };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  programs.home-manager.enable = true;

  eww = {
    enable = true;
    defWindow = {
      statusbar = {
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
      };
    };
    defListen = {
      workspace = {
        command = "python ~/.config/eww/scripts/workspaces.py";
      };
      mpris-title = {
        command = "playerctl -sF metadata title";
      };
      mpris-status = {
        command = "playerctl -sF status";
      };
      network = {
        initial = {
          upload = "0.0/s";
          download = "0.0/s";
        };
        command = "python ~/.config/eww/scripts/network.py";
      };
      memory = {
        initial = {
          memory = "0%";
        };
        command = "python ~/.config/eww/scripts/memory.py";
      };
      cpu = {
        initial = {
          cpu = "0%";
        };
        command = "python ~/.config/eww/scripts/cpu.py";
      };
      battery = {
        initial = {
          percent = "0";
        };
        command = "python ~/.config/eww/scripts/battery.py";
      };
    };
    defVar = {
      mpris-hidden = "true";
    };

    defPoll = {
      dateName = {
        interval = "1s";
        command = "date +%a";
      };
      dateHour = {
        interval = "1s";
        command = "date +%T";
      };
      dateDate = {
        interval = "1s";
        command = "date +%d/%m";
      };
    };
    defWidget = {
      statusbar = {
        centerbox = {
          class = "centerbox";
          orientation = "horizontal";
          children = [
            # --- LEFT: Power, Battery, Workspaces, Player ---
            {
              box = {
                space-evenly = false;
                children = [
                  # Power Button
                  {
                    button = {
                      onclick = "wlogout -p layer-shell&";
                      hexpand = false;
                      class = "powermenu";
                      children = [{ label = { text = "⏻"; }; }];
                    };
                  }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }

                  # Battery
                  {
                    label = {
                      text = "{battery.text}";
                      # Note the escaped quotes (\") for the inner strings
                      class = "{battery.percent > 75 ? \"battery-perfect\" : battery.percent > 50 ? \"battery-good\" : battery.percent > 25 ? \"battery-mid\" : \"battery-bad\"}";
                    };
                  }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }

                  # Workspaces (Using a 'literal' to handle the 'for' loop syntax)
                  # Alternatively, define (defwidget workspaces [] ...) separately and call { workspaces = {}; } here.
                  {
                    literal = {
                      content = ''
                        (box :space-evenly false
                          (for workspace in {workspace}
                            (button :class "workspace" 
                                    :onclick "hyprctl dispatch workspace ''${workspace.id}"
                              (label :text {workspace.active == true ? "" : "" }
                                     :class {workspace.active == true ? "workspace-active" : "workspace" }
                              )
                            )
                          )
                        )
                      '';
                    };
                  }

                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { visible = "{mpris-status != \"\"}"; text = ""; class = "left-starting-arrow"; }; }

                  # MPRIS Player
                  {
                    box = {
                      space-evenly = false;
                      class = "mpris";
                      visible = "{mpris-status != \"\"}";
                      children = [
                        {
                          eventbox = {
                            visible = "{mpris-status != \"\"}";
                            onclick = "playerctl play-pause";
                            onhover = "eww update mpris-hidden=false";
                            onhoverlost = "eww update mpris-hidden=true";
                            children = [
                              {
                                box = {
                                  space-evenly = false;
                                  children = [
                                    # Previous Button
                                    {
                                      revealer = {
                                        reveal = "{ ! mpris-hidden }";
                                        transition = "slideleft";
                                        duration = "500ms";
                                        children = [
                                          {
                                            button = {
                                              class = "mpris-previous";
                                              onclick = "playerctl previous";
                                              children = [{ label = { text = "󰒫"; }; }];
                                            };
                                          }
                                        ];
                                      };
                                    }
                                    # Title
                                    { label = { class = "mpris"; text = "{mpris-title}"; }; }
                                    # Next Button
                                    {
                                      revealer = {
                                        reveal = "{ ! mpris-hidden }";
                                        transition = "slideright";
                                        duration = "500ms";
                                        children = [
                                          {
                                            button = {
                                              class = "mpris-next";
                                              onclick = "playerctl next";
                                              children = [{ label = { text = "󰒬"; }; }];
                                            };
                                          }
                                        ];
                                      };
                                    }
                                    # Play/Pause Icon
                                    { label = { text = "{mpris-status == \"Playing\" ? \"󰏤\" : \"󰐊\"}"; }; }
                                  ];
                                };
                              }
                            ];
                          };
                        }
                      ];
                    };
                  }
                  { label = { visible = "{mpris-status != \"\"}"; text = ""; class = "left-ending-arrow"; }; }
                ];
              };
            }

            # --- CENTER: Date/Time ---
            {
              box = {
                space-evenly = false;
                children = [
                  { label = { text = ""; class = "right-ending-arrow"; }; }
                  { label = { text = "{dateName}"; class = "dateName"; }; }
                  { label = { text = ""; class = "right-starting-arrow"; }; }
                  { label = { text = ""; class = "right-ending-arrow"; }; }
                  { label = { text = "{dateHour}"; class = "dateHour"; }; }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }
                  { label = { text = "{dateDate}"; class = "dateDate"; }; }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                ];
              };
            }

            # --- RIGHT: Network, Mem, CPU, Systray ---
            {
              box = {
                space-evenly = false;
                halign = "end";
                children = [
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { class = "network"; text = " {network.upload} /  {network.download}"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { text = "Mem {memory.memory}"; class = "memory"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { label = { text = "Cpu {cpu.cpu}"; class = "cpu"; }; }
                  { label = { text = ""; class = "left-starting-arrow"; }; }
                  { label = { text = ""; class = "left-ending-arrow"; }; }
                  { systray = { class = "systray"; icon-size = 18; }; }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
