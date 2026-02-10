{ pkgs
, inputs
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
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    walker
    swaylock-effects
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
  ];
}
