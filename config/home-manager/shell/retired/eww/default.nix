{ lib
, machine-name
, ...
}:
let
  middle = (import ./middle.nix {
    inherit lib;
    inherit machine-name;
  }).middle;
  left = (import ./left.nix {
    inherit lib;
    inherit machine-name;
  }).left;
  right = (import ./right.nix {
    inherit lib;
    inherit machine-name;
  }).right;

  monitorNumber = if machine-name == "pc" then 1 else 0;

  batteryAttr =
    if machine-name == "laptop" then {
      battery = {
        initial = {
          percent = "0";
        };
        command = "python ${./scripts/battery.py}";
      };
    } else { };

  playerctlTrunc = if machine-name == "pc" then "40" else "15";
in
{
  eww = {
    enable = true;
    defWindow = {
      statusbar = {
        monitor = monitorNumber;
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
        command = "python ${./scripts/workspaces.py}";
      };
      mpris-title = {
        command = "playerctl -sF metadata --format '{{trunc(title, ${playerctlTrunc})}}'";
      };
      mpris-status = {
        command = "playerctl -sF status";
      };
      network = {
        initial = {
          upload = "0.0/s";
          download = "0.0/s";
        };
        command = "python ${./scripts/network.py}";
      };
      memory = {
        initial = {
          memory = "0%";
        };
        command = "python ${./scripts/memory.py}";
      };
      cpu = {
        initial = {
          cpu = "0%";
        };
        command = "python ${./scripts/cpu.py}";
      };
    } // batteryAttr;
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

    scssPath = ./eww.scss;

    defWidget = ''
      (defwidget statusbar []
        (centerbox
          :class "centerbox"
          :orientation "horizontal"
          ${left}
          ${middle}
          ${right}
        )
      )
    '';
  };
}
