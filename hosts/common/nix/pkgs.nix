{ pkgs, ... }:
{
  nixpkgs = {
    config = {
      problems.handlers = {
        sublimetext4.broken = "warn";
      };
      permittedInsecurePackages = [
        "electron-38.8.4" # legcord
      ];
    };
    overlays = [
      (final: _prev: {
        pnpm_10_29_2 = final.pnpm_10;
      })
    ];
  };

  environment.systemPackages = with pkgs; [
    bruno
    fastfetch
    neovim
    feishin
    wezterm
    pipewire
    legcord
    grimblast
    nh
    git
    (python3.withPackages (ps: [ ps.psutil ]))
    killall
    networkmanagerapplet
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
  ];
}
