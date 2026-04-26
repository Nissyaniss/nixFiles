{ ... }:
{
  imports = [
    ./hardware.nix
    ../common/pkgs.nix
    ./config/nix
    ../../modules/nix
  ];

  home-manager.users.nissya = {
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    imports = [
      ../../modules/home-manager
      ./config/home-manager
    ];

    local.zsh = {
      enable = true;
    };
  };

}
