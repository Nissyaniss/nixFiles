{ inputs
, lib
, ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        imports = [ inputs.spicetify-nix.homeManagerModules.default ];

        programs.spicetify = {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblock
            shuffle
            keyboardShortcut
            copyLyrics
            fullAppDisplay
            beautifulLyrics
            simpleBeautifulLyrics
            spicyLyrics
            aiBandBlocker
            hidePodcasts
          ];
          enabledCustomApps = with spicePkgs.apps; [
            marketplace
            nameThatTune
            ncsVisualizer
          ];
        };
      }
    )
  ];
}
