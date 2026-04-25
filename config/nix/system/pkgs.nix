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
      stoat-desktop
      rustup
      llvmPackages_21.llvm
      llvmPackages_21.clang
      llvmPackages_21.libclang
      lutris-free
    ] else [ ];

  workPackages =
    if machine-name == "work" then with pkgs; [
      remmina
      rocketchat-desktop
      openfortivpn
      symfony-cli
      php
      php84Packages.composer
      php84Packages.php-codesniffer
      php84Packages.phpmd
      obsidian
      phpactor
      php84Packages.php-cs-fixer
      libreoffice-still
      dbeaver-bin
      apache-directory-studio
      rustup
      clang
      llvm
      pkgsCross.mingwW64.buildPackages.binutils
      pkg-config
      mariadb-connector-c
      mariadb
      vcpkg
    ] else [ ];
in
{
  environment.pathsToLink = [ "/include" ];
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
      grimblast
      nixd
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
      swaylock # for debugging the lock
      jq
    ] ++ personnalPackages ++ workPackages;
}
