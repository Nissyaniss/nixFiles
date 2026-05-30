{ inputs
, pkgs
, ...
}:

{
  imports = [
    ../../../common/home-manager/user.nix
  ];

  home.username = "nissya";
  home.homeDirectory = "/home/nissya";
}
