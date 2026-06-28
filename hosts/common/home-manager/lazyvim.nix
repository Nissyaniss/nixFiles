{
  ...
}:
{
  imports = [ ../../../modules/home-manager/lazyvim.nix ];

  local.lazyvim = {
    enable = true;
    lang = {
      rust = {
        enable = true;
        formattersCommands = [
          "cargo fmt"
        ];
      };
      nix = {
        enable = true;
        formattersCommands = [
          "nixfmt"
          "statix"
        ];
      };
    };
    alias = {
      qall = {
        command = "q";
      };
    };
  };
}
