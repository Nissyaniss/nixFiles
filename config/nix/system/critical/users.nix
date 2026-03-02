{ pkgs
, ...
}: {
  users.users.nissya = {
    isNormalUser = true;
    description = "nissya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  users.users.lasbop01 = {
    isNormalUser = true;
    description = "lasbop01";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  users.defaultUserShell = pkgs.nushell;
}
