{ ... }:
{
  imports = [
    ./boot.nix
    ./pkgs.nix
    ./programs.nix
    ./timezone.nix
    ./pipewire.nix
    ./locale.nix
    ./keyboard.nix
    ./bluetooth.nix
    ./stylix.nix
    ./xdg.nix
  ];
}
