{ config, lib, ... }:
let
  cfg = config.local.zsh;

  oh-my-zshType = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      plugins = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "sublime"
          "zoxide"
          "colored-man-pages"
          "command-not-found"
          "rust"
        ];
      };
    };
  };

in
{
  options.local.zsh = {
    enable = lib.mkEnableOption "Enable Zsh";

    autosuggestion.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    syntaxHighlighting.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    oh-my-zsh = lib.mkOption {
      type = oh-my-zshType;
    };

    aliases = lib.mkOption {
      type = lib.types.attrs;
      default = {
        nix-config = "subl ~/.nixFiles";
        update = "npins update && nh os switch --update ~/.nixFiles";
      };
    };

    functions = lib.mkOption {
      type = lib.types.attrs;
      default = {
        mkcd = ''
          mkdir --parents "$1" && cd "$1"
        '';
      };
    };

    starship.transient_prompt = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    lsd.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    bat.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    ripgrep.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    zoxide.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    carapace.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      inherit (cfg) enable;

      autosuggestion.enable = cfg.autosuggestion.enable;
      syntaxHighlighting.enable = cfg.autosuggestion.enable;

      inherit (cfg) oh-my-zsh;

      shellAliases =
        { }
        // lib.optionalAttrs cfg.bat.enable {
          cat = "bat";
        }
        // lib.optionalAttrs cfg.ripgrep.enable {
          grep = "rg";
        }
        // {
          nix-config = "direnv exec ~/.nixFiles/ subl ~/.nixFiles";
          update = "nh os switch --update ~/.nixFiles";
        };

      siteFunctions = cfg.functions;

      initContent =
        if cfg.starship.transient_prompt then
          ''
            function _transient_prompt_redraw() {
              # Save the current Starship prompt state
              local ORIGINAL_PROMPT="$PROMPT"
              local ORIGINAL_RPROMPT="$RPROMPT"

              # Apply the transient profile and redraw the current line
              PROMPT="$(starship prompt --profile transient)"
              RPROMPT=""
              zle reset-prompt

              # Immediately restore the original state for the next command
              PROMPT="$ORIGINAL_PROMPT"
              RPROMPT="$ORIGINAL_RPROMPT"
            }

            zle -N zle-line-finish _transient_prompt_redraw
          ''
        else
          "";
    };

    programs.lsd.enable = cfg.lsd.enable;
    programs.bat.enable = cfg.bat.enable;
    programs.ripgrep.enable = cfg.ripgrep.enable;

    programs.zoxide = {
      enable = cfg.zoxide.enable;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    programs.carapace = {
      enable = cfg.carapace.enable;
      enableZshIntegration = true;
    };
  };
}
