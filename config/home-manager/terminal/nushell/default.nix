{ ...
}:
{
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell =
    {
      enable = true;

      extraConfig = builtins.readFile ./config.nu;
      extraEnv = builtins.readFile ./env.nu;

      shellAliases = {
        ls = "ls -a";
        nix-config = "subl ~/.nixFiles";
        update = "nh os switch --update ~/.nixFiles";
      };
    };
}
