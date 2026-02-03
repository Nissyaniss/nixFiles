{ inputs
, pkgs
, ...
}:

{

  imports = [
    inputs.walker.homeManagerModules.default
    ./config/hyprland
    ./config/nushell
    ./config/starship
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

    font = {
      name = "Noto Sans";
      size = 10;
    };
    cursorTheme = {
      name = "breeze_cursors";
      size = 24;
    };
    iconTheme = {
      package = pkgs.kdePackages.breeze-icons;
      name = "breeze-dark";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
