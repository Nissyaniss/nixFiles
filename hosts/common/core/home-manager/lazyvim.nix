{ ...
}:
{
  local.lazyvim = {
    enable = true;
    lang = {
      rust = {
        enable = true;
        formattersCommands = [
          "rustfmt"
        ];
      };
      nix = {
        enable = true;
        formattersCommands = [
          "nixpkgs_fmt"
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
