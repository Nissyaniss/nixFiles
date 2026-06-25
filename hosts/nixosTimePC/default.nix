{ ... }:
{
  imports = [
    ./hardware.nix
    ../common
    ./config/nix
    ../../modules/nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  home-manager.users.nissya = {
    imports = [
      ../../modules/home-manager
      ./config/home-manager
      ../common/home-manager
    ];

    local.zsh = {
      enable = true;
    };
  };
}
