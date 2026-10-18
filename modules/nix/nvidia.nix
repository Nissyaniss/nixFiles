{ config, lib, ... }:
let
  cfg = config.local.nvidia;

  laptopType = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      intel_bus_id = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      nvidia_bus_id = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };
in
{
  options.local.nvidia = {
    enable = lib.mkEnableOption "Enable Graphics";

    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    laptop = lib.mkOption {
      type = laptopType;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      inherit (cfg) enable;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      inherit (cfg) open;
      nvidiaSettings = true;
      package =
        if cfg.laptop.enable then
          config.boot.kernelPackages.nvidiaPackages.stable
        else
          config.boot.kernelPackages.nvidiaPackages.beta;

      prime =
        if cfg.laptop.enable then
          {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            intelBusId = cfg.laptop.intel_bus_id;
            nvidiaBusId = cfg.laptop.nvidia_bus_id;
          }
        else
          { };
    };

    boot.kernelParams = lib.mkIf cfg.laptop.enable [
      "module_blacklist=nouveau"
      "nvidia-drm.modeset=1"
    ];
  };
}
