{ config, machine-name, ... }:
let
  isOpen = if machine-name == "pc" then true else false;
  laptopExtraParameters =
    if machine-name == "pc" then
      {
        boot.kernelParams = [
          "module_blacklist=nouveau"
          "nvidia-drm.modeset=1"
        ];
      } else
      { };
  primeConfig =
    if machine-name == "pc" then {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    } else
      { };
in
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = isOpen;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    prime = primeConfig;
  };
} // laptopExtraParameters
