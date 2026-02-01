{ inputs, ... }:

let
  hyprlandSettings = import ./settings.nix;
  hyprlandbind = import ./keymaps/bind.nix;
  hyprlandbindm = import ./keymaps/bindm.nix;
in
{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    plugins = [
      #...
    ];
    settings = hyprlandSettings // hyprlandbind // hyprlandbindm;
  };
}
