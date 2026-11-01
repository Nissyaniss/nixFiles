# Theme comes from https://github.com/facelessuser/merge-dracula-theme and https://github.com/facelessuser/sublime-dracula-scheme
{ lib
, config
, ...
}:
let
  cfg = config.local.sublime-merge;

  linkInto = source: {
    inherit source;
    recursive = true;
    force = true;
  };
in
{
  options.local.sublime-merge.enable = lib.mkEnableOption "the Dracula theme for Sublime Merge";

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "sublime-merge/Packages/Theme - Merge" = linkInto ./theme;
      "sublime-merge/Packages/User" = linkInto ./user;
    };
  };
}
