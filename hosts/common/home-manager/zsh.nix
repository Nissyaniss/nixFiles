{ ... }: {
  imports = [
    ../../../modules/home-manager/zsh.nix
  ];

  local.zsh = {
    enable = true;
  };
}
