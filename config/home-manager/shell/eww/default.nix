{ machine-name
, ...
}:
{
  programs.eww = {
    enable = true;
    configDir = ./${machine-name}; # nix thinks this is bad but it is not
  };
}
