{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bruno
    feishin
    wezterm
    grimblast
    networkmanagerapplet
    playerctl
    alsa-utils
    sublime-merge
    sddm-astronaut
    kdePackages.dolphin
    kdePackages.qtsvg # for dolphin
    kdePackages.kio
    kdePackages.kio-fuse # to mount remote filesystems
    kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    kdePackages.ark # for extract
    libnotify
    vlc
    eog
    zathura
    qt6.qt5compat
    kdePackages.qtdeclarative
    grim
    piper
    # swaylock # for debugging the lock
    pwvucontrol
    mission-center
    wl-clipboard
    telegram-desktop
    bitwarden-desktop
  ];
}
