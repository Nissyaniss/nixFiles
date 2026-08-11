{ ... }: {
  imports = [
    ./nix.nix
    ./pkgs.nix
    ./programs.nix
    ./user.nix
    ./sddm.nix
    ./storage.nix
    ./graphics.nix
    ./network.nix
    ./helium.nix
    ./waydroid.nix
  ];
}
