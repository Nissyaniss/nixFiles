{ ... }: {
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        # copied from mimeapps at the time
        "x-scheme-handler/discord" = "discord=vesktop.desktop";
        "x-scheme-handler/bruno" = "bruno.desktop";
        "x-scheme-handler/magnet" = "userapp-transmission-gtk-P9XGM3.desktop";
        "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
        "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/chrome" = "zen-beta.desktop";
        "text/html" = "zen-beta.desktop";
        "application/x-extension-htm" = "zen-beta.desktop";
        "application/x-extension-html" = "zen-beta.desktop";
        "application/x-extension-shtml" = "zen-beta.desktop";
        "application/xhtml+xml" = "zen-beta.desktop";
        "application/x-extension-xhtml" = "zen-beta.desktop";
        "application/x-extension-xht" = "zen-beta.desktop";
        "x-scheme-handler/bitwarden" = "bitwarden.desktop";
        "x-scheme-handler/hydralauncher" = "hydralauncher.desktop";
        "application/json" = "sublime_text.desktop";
      };
    };
}
