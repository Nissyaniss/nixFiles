{ inputs
, ...
}:

{

  home.username = "root";
  home.homeDirectory = "/root";

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

  programs.home-manager.enable = true;

}
