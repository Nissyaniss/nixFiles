{
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
    "SUPER, SUPER_L, exec, sh ${./bindmScripts/openLauncher.sh}" # start launcher
    "SUPER, P, exec, wleave" # start wleave
    "SUPER SHIFT, F, fullscreen, 2"
    "SUPER SHIFT, R, exec, sh ${./bindScripts/toggle_span.sh}"
  ];
}

