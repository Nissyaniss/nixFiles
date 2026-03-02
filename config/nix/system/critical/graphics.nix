{ config, machine-name, ... }:
let
  isOpen = if machine-name == "pc" then true else false;
  laptopExtraParameters =
    if machine-name == "laptop" then
      {
        boot.kernelParams = [
          "module_blacklist=nouveau"
          "nvidia-drm.modeset=1"
        ];
      } else
      { };
  primeConfig =
    if machine-name == "laptop" then {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    } else
      { };

  package =
    if machine-name == "laptop" then
      config.boot.kernelPackages.nvidiaPackages.stable
    else
      config.boot.kernelPackages.nvidiaPackages.beta
  ;
in
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = if machine-name == "work" then false else true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = isOpen;
    nvidiaSettings = true;
    package = package;

    prime = primeConfig;
  };
} // laptopExtraParameters
