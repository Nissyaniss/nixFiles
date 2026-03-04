{ pkgs
, machine-name
, ...
}:
let
  personnalPackages =
    if machine-name != "work" then with pkgs; [
      linux-wallpaperengine
      prismlauncher
      heroic
      gamescope
      mangohud
      protonplus
      balatro-mod-manager
      transmission_4-gtk
    ] else [ ];

  workPackages =
    if machine-name == "work" then with pkgs; [
      remmina
      rocketchat-desktop
      openfortivpn
      symfony-cli
      php
      php84Packages.composer
    ] else [ ];
in
{
  environment.systemPackages = with pkgs;
    [
      bruno
      fastfetch
      neovim
      feishin
      wezterm
      pipewire
      sublime4
      legcord
      walker
      grimblast
      nixd
      nh
      git
      (python3.withPackages (ps: [ ps.psutil ]))
      killall
      networkmanagerapplet
      zoxide
      playerctl
      alsa-utils
      sublime-merge-dev
      nodejs
      sddm-astronaut
      nautilus
      libnotify
      vlc
      eog
      zathura
      qt6.qt5compat
      kdePackages.qtdeclarative
      grim
      hyprland
      devenv
    ] ++ personnalPackages ++ workPackages;
}
