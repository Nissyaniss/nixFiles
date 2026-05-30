{ ...
}:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
    "openssl-1.1.1w"
  ];

  imports = [
    ./config/nix
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
  };

  nixpkgs.overlays = [
    # Skipping tests while upstream sorts it out, revert once
    # Hydra consistently builds openldap green.
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/4979a195-a58c-4e11-ade3-c72d9b068986";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults" 
      # boot options for fstab. Search up fstab mount options you can use
      "x-gvfs-show"
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
    ];
  };
}
