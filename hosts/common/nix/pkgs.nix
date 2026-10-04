{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bruno
    fastfetch
    neovim
    feishin
    wezterm
    pipewire
    vesktop
    grimblast
    nh
    git
    (python3.withPackages (ps: [ ps.psutil ]))
    killall
    networkmanagerapplet
    playerctl
    alsa-utils
    sublime-merge
    nodejs
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
    hyprland
    openssl
    delta
    upower
    piper
    # swaylock # for debugging the lock
    jq
    claude-code
    zip
    unzip
    pear-desktop
    pwvucontrol
    mission-center
    wl-clipboard
    telegram-desktop
    quickshell
    npins
    bitwarden-desktop
  ];
}
