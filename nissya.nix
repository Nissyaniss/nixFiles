{ inputs
, ...
}:

{

  imports = [
    inputs.walker.homeManagerModules.default
    ./config/hyprland/default.nix
  ];
  home.username = "nissya";
  home.homeDirectory = "/home/nissya";

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
