{ pkgs
, machine-name
, ...
}:
let
  me =
    if machine-name != "work" then {
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
    } else {
      lasbop01 = {
        isNormalUser = true;
        description = "lasbop01";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
      };
    };
in
{
  users.users = { } // me;
  users.defaultUserShell = pkgs.zsh;
}
