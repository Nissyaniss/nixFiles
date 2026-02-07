{ ... }: {
  programs.rclone = {
    enable = true;
    remotes = {
      copyparty = {
        config = {
          type = "webdav";
          url = "https://copyparty.shittydomain.company";
          vendor = "owncloud";
          pacer_min_sleep = "0.01ms";
          user = "Nissya";
          pass = "7QSnM_syUUdpS_i3JnyWEo2pQii3q19uFs9R-fZ5SEE";
        };
        mounts = {
          "/" = {
            enable = true;
            mountPoint = "/mnt/copyparty";

            options = {
              vfs-cache-mode = "writes";
              dir-cache-time = "5s";
            };
          };
        };
      };
    };
  };
}
