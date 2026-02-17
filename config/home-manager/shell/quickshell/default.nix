{ ... }: {
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
    "QML_XHR_ALLOW_FILE_READ=1"
  ];
}
