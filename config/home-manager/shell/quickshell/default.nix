{ ... }: {
  programs.quickshell = {
    enable = true;

    activeConfig = "test";
    configs = {
      test = ./configs/test;
    };
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}

# programs.quickshell = {
#   enable = true;

#   test = {
#     activeConfig = "test";
#     configs.test = ./quickshell;
#     systemd = {
#       enable = true;
#       target = "graphical-session.target";
#     };
#   };
# };
