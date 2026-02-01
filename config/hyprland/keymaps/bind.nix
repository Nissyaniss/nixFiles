{
  settings = {
    bind = [
      "SUPER + ALT_L, UP, movetoworkspace, +1" # move workspace up
      "SUPER + ALT_L, DOWN, movetoworkspace, -1" # move workspace down
      "SUPER, S, togglespecialworkspace, magic" # toggle magic workspace
      "SUPER, V, fullscreen, 1" # toggle fullscreen
      "SUPER, L, exec, swaylock" # toggle swaylock
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
    ];
  };
}
