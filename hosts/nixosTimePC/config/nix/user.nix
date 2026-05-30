{ pkgs, ... }: {
  users.users = {
    nissya = {
      isNormalUser = true;
      description = "nissya";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "dialout"
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
