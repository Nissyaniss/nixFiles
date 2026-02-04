{ pkgs, inputs
, ...
}: {
  environment.systemPackages = with pkgs; [
    fastfetch
    neovim
    modrinth-app
    feishin
    wezterm
    pipewire
    sublime4
    legcord
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    walker
    swaylock-effects
    grimblast
    wleave
    eww
    nixd
    nh
    git
    (python3.withPackages (ps: [ ps.psutil ]))
    linux-wallpaperengine
    killall
    networkmanagerapplet
    carapace
    starship
    zoxide
    prismlauncher
    playerctl
    alsa-utils
    sublime-merge-dev
    nodejs
    sddm-astronaut
  ];
}
