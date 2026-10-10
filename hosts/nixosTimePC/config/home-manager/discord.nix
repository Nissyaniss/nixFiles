{ inputs
, system
, ...
}:
let
  nixcord = import (import ../../../../npins).nixcord {
    nixpkgs = inputs.nixpkgs;
    system = system;
  };
in
{
  imports = [ nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord.enable = false;

    discord.vencord.enable = true;

    vesktop = {
      enable = true;
    };

    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      enableReactDevtools = true;
      plugins = {
        betterGifPicker.enable = true;
        biggerStreamPreview.enable = true;
        clearUrls.enable = true;
        copyFileContents.enable = true;
        fakeProfileThemes.enable = true;
        fixCodeblockGap.enable = true;
        fixDiscordCss.enable = true;
        fixImagesQuality.enable = true;
        gameActivityToggle.enable = true;
        imageZoom.enable = true;
        noMiddleClickPaste.enable = true;
        noOnboardingDelay.enable = true;
        notificationVolume = {
          enable = true;
          notificationVolume = 50.0;
        };
        permissionsViewer.enable = true;
        replaceGoogleSearch = {
          enable = true;
          replacementEngine = "Startpage";
        };
        reverseImageSearch.enable = true;
        shikiCodeblocks = {
          enable = true;
          theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/dracula.json";
        };
        showHiddenThings = {
          enable = true;
          showInvitesPaused = false;
          showModView = true; # default is true for the both of them but more readable this way
          showTimeouts = true;
        };
        showTimeoutDuration.enable = true;
        unlockedAvatarZoom.enable = true;
        userMessagesPronouns.enable = true;
        usrbg.enable = true;
        validUser.enable = true;
        viewIcons.enable = true;
        volumeBooster.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
        messageLogger.enable = true; # marked as equicord only but is not ?
      };
    };
  };
}
