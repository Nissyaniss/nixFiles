{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.sddm;

  setupScript = lib.types.submodule {
    options = {
      monitor = lib.mkOption {
        type = lib.types.str;
      };

      resolution = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      refreshRate = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };

      primary = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      deactivate = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
in
{
  options.sddm = {
    enable = lib.mkEnableOption "Enable SDDM";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "sddm-astronaut-theme";
    };

    themePackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.sddm-astronaut;
    };

    setupScript = lib.mkOption {
      type = lib.types.listOf setupScript;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = false;
        theme = cfg.theme;
        extraPackages = [ cfg.themePackage ];
        settings = {
          General = { InputMethod = ""; };
        };
      };
      services.xserver.displayManager.setupCommands = lib.concatMapStrings
        (item:
          if item.deactivate == true then
            ''
              ${pkgs.xorg.xrandr}/bin/xrandr --output ${item.monitor} --off
            ''
          else if item.primary == true then
            ''
              ${pkgs.xorg.xrandr}/bin/xrandr --output ${item.monitor} --primary --mode ${item.resolution} --rate ${toString item.refreshRate} --rotate normal
            ''
          else
            ''
              ${pkgs.xorg.xrandr}/bin/xrandr --output ${item.monitor} --mode ${item.resolution} --rate ${toString item.refreshRate} --rotate normal
            ''
        )
        cfg.setupScript;
      systemd.services.display-manager.environment = {
        QT_IM_MODULE = lib.mkForce "none";
        QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = lib.mkForce "1";
      };
      services.xserver.enable = true;

      environment.systemPackages = with pkgs; [
        cfg.themePackage
      ];
    };
}
