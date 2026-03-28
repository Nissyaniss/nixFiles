{ ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
    "openssl-1.1.1w"
  ];

  imports = [
    ./config/nix
  ];
}
