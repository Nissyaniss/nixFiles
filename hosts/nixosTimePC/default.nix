{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

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

  nix.settings.trusted-users = [ "root" "nissya" ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  programs.zsh.enable = true;

  users.users = {
    nissya = {
      isNormalUser = true;
      description = "nissya";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  boot.loader.systemd-boot.enable = true;


  home-manager.users.nissya = {
    imports = [ ../../modules/home-manager ];

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    local.hyprland = {
      enable = true;
      exec-once = [
        "blueman-applet"
        "legcord"
        "hyprctl setcursor breeze_cursors 24"
        "wleave --service"
      ];

      enable_logs = true; # false to have logs

      env = [
        "XCURSOR_SIZE,24"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow" # move window with left click
        "SUPER, mouse:273, resizewindow" # resize window with right click
      ];


      bind = [
        "SUPER + ALT_L, UP, movetoworkspace, +1" # move window to workspace left
        "SUPER + ALT_L, DOWN, movetoworkspace, -1" # move window to workspace right
        "SUPER + ALT_L, RIGHT, workspace, +1" # move to workspace right
        "SUPER + ALT_L, LEFT, workspace, -1" # move to workspace left
        "SUPER, S, togglespecialworkspace, magic" # toggle magic workspace
        "SUPER, V, fullscreen, 1" # toggle fullscreen
        "SUPER, L, exec, for output in $(hyprctl monitors -j | jq -r '.[].name'); do grim -o \"$output\" \"/tmp/lock_bg_\${output}.png\"; done; qs -p ~/.config/quickshell/default/lock/Lock.qml; rm -f /tmp/lock_bg_*.png" # toggle lock
        "SUPER, F, exec, zen" # open zen
        "SUPER_SHIFT_L, S, exec, grimblast copy area" # screenshot
        "SUPER, T, exec, wezterm" # open wezterm
        "SUPER, D, exec, sh ~/.config/hypr/scripts/legcordControl.sh" # WIP: open and close legcord/discord on Win+D
        "SUPER, C, killactive" # killactive duh
        "SUPER, LEFT, movefocus, l" # move focus to the left  
        "SUPER, RIGHT, movefocus, r" # move focus to the right
        "SUPER, UP, movefocus, u" # move focus up
        "SUPER, DOWN, movefocus, d" # move focus down
        "SUPER, W, togglefloating" # toggle floating on focused window
        # "SUPER, SUPER_L, exec, sh ${./bindmScripts/openLauncher.sh}" # start launcher
        "SUPER, P, exec, wleave" # start wleave
        "SUPER SHIFT, F, fullscreen, 2"
        # "SUPER SHIFT, R, exec, sh ${./bindScripts/toggle_span.sh}"
      ];
    };

    local.zsh = {
      enable = true;
    };
  };

}
