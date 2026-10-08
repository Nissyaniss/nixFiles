{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  pear-desktop-nix = (import ../../../../npins).pear-desktop-nix;
in
{
  imports = [
    (import "${pear-desktop-nix}/nix/homeManagerModule" {
      pearLib = import "${pear-desktop-nix}/nix/lib" { inherit lib; };
    })
  ];

  programs.pear-desktop = {
    enable = true;
    options = {
      likeButtons = "hide";
      removeUpgradeButton = true;
      resumeOnStart = true;
      startingPage = "Library";
      tray = true;
    };
    plugins = {
      album-color-theme = {
        enable = true;
        enableSeekbar = true;
      };
      ambient-mode = {
        enable = true;
      };
      discord = {
        enable = true;
        activityTimeoutTime = 300;
      };
      downloader = {
        enable = true;
      };
      scrobbler = {
        enable = true;
        scrobblers.listenbrainz = {
          enable = true;
        };
      };
      lyrics-genius = {
        enable = true;
        romanizedLyrics = true;
      };
      music-together = {
        enable = true;
      };
      navigation = {
        enable = true;
      };
      shortcuts = {
        enable = true;
      };
      skip-disliked-songs = {
        enable = true;
      };
      synced-lyrics = {
        enable = true;
      };
      unobtrusive-player = {
        enable = true;
      };
      video-toggle = {
        enable = true;
      };
      do-not-track = {
        enable = true;
      };
    };
  };

}
