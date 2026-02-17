{ pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
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
    linux-wallpaperengine
    killall
    networkmanagerapplet
    zoxide
    prismlauncher
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
    heroic
    gamescope
    mangohud
    qt6.qt5compat
    kdePackages.qtdeclarative
    protonplus
    grim
  ];
}
