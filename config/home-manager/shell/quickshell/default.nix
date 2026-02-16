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
}
