{ machine-name
, ...
}: {
  services.xserver.xkb = {
    layout = if machine-name == "work" then "fr" else "us";
    variant = if machine-name == "work" then "oss" else "";
  };
}
