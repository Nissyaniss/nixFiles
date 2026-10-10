{ inputs, ... }:
let
  nixcord = import (import ../../../../npins).nixcord {
    nixpkgs = inputs.nixpkgs;
    system = inputs.system;
  };
in
{
  imports = [ nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord.enable = false;

    vesktop = {
      enable = true;
    };

    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      enableReactDevtools = true;
      plugins = {
        accountPanelServerProfile.enable = true;
      };
    };
  };
}
