{ pkgs, ... }: {
  users.users = {
    nissya = {
      isNormalUser = true;
      description = "nissya";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
