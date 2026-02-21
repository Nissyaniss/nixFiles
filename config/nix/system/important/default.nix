{ ... }: {
  imports = [
    ./home-manager
    ./keyboard.nix
    ./locale.nix
    ./pipewire.nix
    ./timezone.nix
    ./hyprland.nix
    ./bluetooth.nix
  ];
}

