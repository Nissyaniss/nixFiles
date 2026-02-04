# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs
, inputs
, self
, ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./config/nix
  ];

  users.defaultUserShell = pkgs.nushell;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.nissya = {
    isNormalUser = true;
    description = "nissya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  virtualisation.docker.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    users = {
      "nissya" = import ./nissya.nix;
      "root" = import ./root.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

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
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  hardware.graphics = {
    enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
  };

  programs.steam.enable = true;

  programs.nm-applet.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig = {
      pipewire."99-no-crackling" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
          "default.clock.quantum" = 1024;
          "default.clock.rate" = 48000;
        };
      };
    };
  };

}
