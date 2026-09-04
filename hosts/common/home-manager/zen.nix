{
  pkgs,
  inputs,
  ...
}:
let
  sources = import ../../../npins;
  zen-flake = import (sources.zen-browser-flake + "/flake.nix");
  zen-outputs = zen-flake.outputs {
    self = zen-outputs // {
      inherit (sources.zen-browser-flake) outPath;
    }; # need self and outPath as the flake needs it but they are not given automatically
    nixpkgs = pkgs // {
      legacyPackages."x86_64-linux" = pkgs;
    }; # same normally given but not here
    inherit (inputs) home-manager;
  };
  zen-hm-module = zen-outputs.homeModules.beta;

  MkExtensions = builtins.mapAttrs (
    _: pluginId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
      installation_mode = "force_installed";
    }
  );
in
{
  imports = [
    zen-hm-module
  ];

  stylix.targets.zen-browser.profileNames = [ "default" ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    languagePacks = [ "en" ];
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      SanitizeOnShutdown = {
        FormData = true;
        Cache = true;
      };
      SearchEngines = {
        Default = "StartPage";
        Add = [
          {
            Name = "StartPage";
            URLTemplate = "https://www.startpage.com/sp/search?q={searchTerms}";
          }
          {
            Name = "Nix Packages";
            URLTemplate = "https://search.nixos.org/packages?type=packages&channel=unstable&query={searchTerms}";
            IconURL = "file://${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            Alias = "np";
          }
        ];
      };
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
      ExtensionSettings = MkExtensions {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        "addon@darkreader.org" = "darkreader";
        "{e8ffc3db-2875-4c7f-af38-d03e7f7f8ab9}" = "docsafterdark";
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = "indie-wiki-buddy";
        "{c84d89d9-a826-4015-957b-affebd9eb603" = "mal-sync";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-";
      };
    };
    profiles = {
      default = {
        settings = {
          "zen.window-sync.enabled" = false;
          "zen.welcome-screen.seen" = true;
        };
        isDefault = true;
        mods = [
          "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
          "72f8f48d-86b9-4487-acea-eb4977b18f21" # Better CtrlTab Panel
          "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
          "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
          "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        ];
        extensionButtons = {
          "nav-bar" = [
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" # Bitwarden
            "addon@darkreader.org" # darkreader
          ];
        };
        presets = {
          betterfox.enable = true; # Better Telemetry/privacy
          arkenfox.enable = true; # Same
        };
      };
    };
  };

}
