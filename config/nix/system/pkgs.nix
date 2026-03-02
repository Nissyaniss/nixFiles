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
    ] else [ ];
in
{
  environment.systemPackages = with pkgs;
    [
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
      transmission_4-gtk
      qt6.qt5compat
      kdePackages.qtdeclarative
      grim
    ] ++ personnalPackages;
}
