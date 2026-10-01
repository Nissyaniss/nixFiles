{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    prismlauncher
    heroic
    gamescope
    mangohud
    protonplus
    balatro-mod-manager
    transmission_4-gtk
    llvmPackages_21.llvm
    llvmPackages_21.clang
    llvmPackages_21.libclang
    android-tools
    gamemode
    obsidian
    protontricks
    hydralauncher
    winetricks
    dolphin-emu
    yt-dlp
    ffmpeg
  ];
}
