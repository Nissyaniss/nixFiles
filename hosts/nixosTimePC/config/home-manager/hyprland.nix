{ ... }:
let
  dispatchers = {
    exec = command: "hl.dsp.exec_cmd(${builtins.toJSON command})";
    focus = {
      workspace = workspace: "hl.dsp.focus({ workspace = \"${workspace}\" })";
      direction = direction: "hl.dsp.focus({ direction = \"${direction}\" })";
    };
    workspace.toggle_magic = "hl.dsp.workspace.toggle_special(\"magic\")";
    window = {
      drag = "hl.dsp.window.drag()";
      resize = "hl.dsp.window.resize()";
      close = "hl.dsp.window.close()";
      float = "hl.dsp.window.float({ action = \"toggle\" })";
      fullscreen = mode: "hl.dsp.window.fullscreen({ mode = \"${mode}\", action = \"toggle\" })";
      move.workspace = workspace: "hl.dsp.window.move({ workspace = \"${workspace}\" })";
    };
  };
in
{
  local.hyprland = {
    enable = true;

    config = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
      };
    };

    exec-once = [
      "blueman-applet"
      "legcord"
      "hyprctl setcursor breeze_cursors 24"
      "wleave --service"
    ];

    env = {
      XCURSOR_SIZE = "24";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    monitors = [
      {
        output = "DP-1";
        mode = "2560x1440@144";
      }
      {
        output = "HDMI-A-1";
        mode = "1360x768@60";
        position = "2560x672";
      }
    ];

    binds = {
      "SUPER + mouse:272" = dispatchers.window.drag;
      "SUPER + mouse:273" = dispatchers.window.resize;
      "SUPER + ALT_L + UP" = dispatchers.window.move.workspace "+1";
      "SUPER + ALT_L + DOWN" = dispatchers.window.move.workspace "-1";
      "SUPER + ALT_L + RIGHT" = dispatchers.focus.workspace "+1";
      "SUPER + ALT_L + LEFT" = dispatchers.focus.workspace "-1";
      "SUPER + S" = dispatchers.workspace.toggle_magic;
      "SUPER + V" = dispatchers.window.fullscreen "maximized";
      "SUPER + L" =
        dispatchers.exec "for output in $(hyprctl monitors -j | jq -r '.[].name'); do grim -o \"$output\" \"/tmp/lock_bg_\${output}.png\"; done; qs -p ~/.config/quickshell/default/lock/Lock.qml; rm -f /tmp/lock_bg_*.png";
      "SUPER + F" = dispatchers.exec "zen-beta";
      "SUPER + SHIFT + S" = dispatchers.exec "grimblast copy area";
      "SUPER + T" = dispatchers.exec "wezterm";
      "SUPER + C" = dispatchers.window.close;
      "SUPER + LEFT" = dispatchers.focus.direction "left";
      "SUPER + RIGHT" = dispatchers.focus.direction "right";
      "SUPER + UP" = dispatchers.focus.direction "up";
      "SUPER + DOWN" = dispatchers.focus.direction "down";
      "SUPER + W" = dispatchers.window.float;
      "SUPER + SUPER_L" =
        dispatchers.exec "sh ${../../../common/home-manager/hyprland/scripts/openLauncher.sh}";
      "SUPER + P" = dispatchers.exec "wleave";
      "SUPER + SHIFT + F" = dispatchers.window.fullscreen "fullscreen";
    };

  };
}
