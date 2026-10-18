{ ... }: {
  imports = [
    ./nix.nix
    ./pkgs.nix
    ./programs.nix
    ./sddm.nix
    ./storage.nix
    ./graphics.nix
    ./waydroid.nix
    ./virtualisation.nix
  ];
}
