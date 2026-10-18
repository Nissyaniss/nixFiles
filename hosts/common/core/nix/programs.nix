_: {
  security.sudo-rs.enable = true;
  programs.zsh.enable = true;
  virtualisation.docker.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 7d";
  };
}
