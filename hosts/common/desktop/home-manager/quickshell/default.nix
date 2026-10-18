_: {
  programs.quickshell = {
    enable = true;

    activeConfig = "default";
    configs = {
      default = ./configs/default;
    };
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  systemd.user.services.quickshell.Service.Environment = [
    "QSG_RHI_BACKEND=vulkan"
  ];
}
