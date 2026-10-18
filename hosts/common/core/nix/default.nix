{ ... }: {
  imports = [
    ./boot.nix
    ./timezone.nix
    ./locale.nix
    ./keyboard.nix
    ./nix.nix
    ./pkgs.nix
    ./programs.nix
    ./user.nix
  ];
}
