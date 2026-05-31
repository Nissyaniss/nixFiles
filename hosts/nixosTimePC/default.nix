{ ... }:
{
  imports = [
    ./hardware.nix
    ../common
    ./config/nix
    ../../modules/nix
  ];

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
