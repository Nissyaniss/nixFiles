{ ...
}:
{
  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "sublime" "zoxide" "colored-man-pages" "command-not-found" "rust" ];
    };
    shellAliases = {
      nix-config = "subl ~/.nixFiles";
      update = "nh os switch --update ~/.nixFiles";
      cat = "bat";
      grep = "rg";
    };
    siteFunctions = {
      mkcd = ''
        mkdir --parents "$1" && cd "$1"
      '';
    };
    initContent = ''
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
    '';
  };
  programs.lsd.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  # programs.nushell =
  #   {
  #     enable = false;

  #     extraConfig = builtins.readFile ./config.nu;
  #     extraEnv = builtins.readFile ./env.nu;

  #     shellAliases = {
  #       ls = "ls -a";
  #       nix-config = "subl ~/.nixFiles";
  #       update = "nh os switch --update ~/.nixFiles";
  #     };
  #   };
}
