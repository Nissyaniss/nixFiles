{ machine-name
, ...
}: {
  programs.steam.enable =
    if machine-name != "work" then true else false;
}
