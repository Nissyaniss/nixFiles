{ ... }: {
  local.thunar = {
    enable = true;
    customActions."Open Wezterm Here" = {
      id = "terminal-here-1";
      command = "wezterm start --cwd %f";
      description = "Open WezTerm in this folder";
      icon = "wezterm";
    };
  };
}
