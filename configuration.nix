{ ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
    "openssl-1.1.1w"
  ];

  imports = [
    ./config/nix
  ];

  nixpkgs.overlays = [
    # Skipping tests while upstream sorts it out, revert once
    # Hydra consistently builds openldap green.
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}
