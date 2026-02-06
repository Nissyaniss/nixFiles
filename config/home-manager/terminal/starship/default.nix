{ ...
}:
{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [╭─](#6C6C6C)$os''${custom.root_without_git}''${custom.root_with_git}''${custom.without_git}''${custom.with_git}''${custom.without_git_and_at_home}$git_branch$git_status$fill$status$cmd_duration[─╮ ](#6C6C6C)
        [╰─ ](#6C6C6C)'';
      add_newline = false;
      right_format = "[─╯](#6C6C6C) ";

      #  7m 22s 
      cmd_duration = {
        format = "[](#6C6C6C bg:#444444)[ $duration  ]($style)";
        style = "bg:#444444 fg:#A8A8A8";
        min_time = 1000;
        show_notifications = false;
      };

      #    ~/test    master 
      git_branch = {
        format = "[](#6C6C6C bg:#444444)[   $branch ]($style)";
        style = "bg:#444444 fg:#5CCC13";
      };

      git_status = {
        format = "[$all_status ]($style)[](fg:#444444)";
        style = "bg:#444444 fg:#5CCC13";
      };

      status = {
        format = "[](#444444)[ $symbol ]($style)";
        style = "bg:#444444";
        success_symbol = "[✔](#5FAF00 bg:#444444)";
        symbol = "[$status ✘](#D70000 bg:#444444)";
        disabled = false;
      };

      fill = {
        symbol = "─";
        style = "#6C6C6C";
      };

      os = {
        format = "[ $symbol ]($style)";
        style = "bg:#444444 fg:#EEEEEE";
        disabled = false;
        symbols = {
          NixOS = "";
        };
      };

      custom.without_git_and_at_home = {
        when = "nu ${./scripts/isntGitAndIsAtHome.nu}";
        format = "[ ](fg:#6C6C6C bg:#444444)[ ~ ](bg:#444444 fg:#0997D5)[](fg:#444444)";
      };


      custom.without_git = {
        command = "nu ${./scripts/getDirectoryRelativeToHome.nu}";
        when = "nu ${./scripts/isntGit.nu}";
        format = "[ ](fg:#6C6C6C bg:#444444)[ ](bg:#444444 fg:#0997D5)[$output ](bg:#444444 fg:#0997D5)[](fg:#444444)";
      };

      custom.with_git = {
        command = "nu ${./scripts/getDirectoryRelativeToHome.nu}";
        when = "nu ${./scripts/isGit.nu}";
        format = "[ ](fg:#6C6C6C bg:#444444)[ ](bg:#444444 fg:#0997D5)[$output ](bg:#444444 fg:#0997D5)";
      };

      custom.root_without_git = {
        command = "nu ${./scripts/getDirectoryRelativeToRoot.nu}";
        when = "nu ${./scripts/isntGitAndIsRoot.nu}";
        format = "[ ](fg:#6C6C6C bg:#444444)[ /](bg:#444444 fg:#0997D5)[$output ](bg:#444444 fg:#0997D5)[](fg:#444444)";
      };

      custom.root_with_git = {
        command = "nu ${./scripts/getDirectoryRelativeToRoot.nu}";
        when = "nu ${./scripts/isGitAndIsRoot.nu}";
        format = "[ ](fg:#6C6C6C bg:#444444)[ /](bg:#444444 fg:#0997D5)[$output ](bg:#444444 fg:#0997D5)";
      };
    };
  };
}
