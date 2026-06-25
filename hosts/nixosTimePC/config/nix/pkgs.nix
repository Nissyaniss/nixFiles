{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    android-tools
  ];
}
