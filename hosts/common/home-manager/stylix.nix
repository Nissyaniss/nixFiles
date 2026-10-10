{ pkgs, ... }: {
  imports = [
    (import (import ../../../npins).stylix).homeModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets = {
      rofi.enable = false; # why is it enable by default ???
      spicetify.colors.enable = true;
      nixcord.enable = false;
    };
    overlays.enable = false; # home manager ignores them
  };
}
