{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkOption
    ;
  cfg = config.local.lazyvim;

  langTypes = lib.types.submodule (
    { lang, ... }:
    {
      options = {
        lang = mkOption {
          type = lib.types.str;
          default = lang;
        };

        enable = mkOption {
          type = lib.types.bool;
          default = false;
        };

        formattersCommands = mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };
    }
  );

  aliasType = lib.types.submodule (
    { aliasName, ... }:
    {
      options = {
        alias = mkOption {
          type = lib.types.str;
          default = aliasName;
        };

        command = mkOption {
          type = lib.types.str;
          default = "";
        };
      };
    }
  );
in
{
  imports = [
    "${(import ../../npins).lazyvim-nix}/nix/module.nix"
  ];

  options.local.lazyvim = {
    enable = lib.mkEnableOption "Enable Lazyvim";

    alias = mkOption {
      type = lib.types.attrsOf aliasType;
    };

    lang = mkOption {
      type = lib.types.attrsOf langTypes;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.lazyvim = {
      inherit (cfg) enable;
      extras = {
        lang = lib.attrsets.concatMapAttrs (name: lang: {
          ${name}.enable = lang.enable;
        }) cfg.lang;
      };
      config = {
        autocmds = "${lib.concatMapAttrsStringSep "\n" (name: alias: ''
          vim.cmd([[cnoreabbrev ${alias.command} ${name}]])
        '') cfg.alias}";
      };
      plugins = {
        formatting = ''
          return {
            "stevearc/conform.nvim",
            optional = true,
            opts = {
              formatters_by_ft = {
              ${lib.concatMapAttrsStringSep "\n" (name: lang: ''
                ${name} = { ${builtins.concatStringsSep " ," (map (x: ''"${x}"'') lang.formattersCommands)} },
              '') cfg.lang}
              },
            },
          }
        '';
      };
    };
  };
}
