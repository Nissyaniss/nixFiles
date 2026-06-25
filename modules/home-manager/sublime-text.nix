{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    types
    literalExpression

    optionalAttrs
    filterAttrs
    concatMapAttrs
    unique
    mapAttrsToList
    ;
  cfg = config.sublime-text;

  defaultSublime = {
    home.packages = [ cfg.package ];
    xdg.configFile = {
      "${userConfigDirectory}/Preferences.sublime-settings".source =
        jsonFormat.generate "sublime-text-settings"
          (
            (optionalAttrs (cfg.font != null) {
              font_face = "FiraCode Nerd Font Mono";
            })
            // {
              sublime_merge_path = "${pkgs.sublime-merge}/bin/sublime_merge";
            }
            // cfg.settings
          );
      "${userConfigDirectory}/Default (Linux).sublime-keymap".source =
        jsonFormat.generate "sublime-text-keymap" cfg.keymap;
      "${userConfigDirectory}/Package Control.sublime-settings".source =
        jsonFormat.generate "sublime-text-package-control"
          {
            bootstrapped = true;
            in_process_packages = [ ];
            installed_packages = builtins.attrNames (filterAttrs (_: plugin: plugin.managed) cfg.plugins);
            repositories = unique (
              builtins.filter (repo: repo != null) (
                mapAttrsToList (_: plugin: plugin.repository or null) cfg.plugins
              )
            );
          };
    }
    // (concatMapAttrs (name: plugin: {
      "${userConfigDirectory}/${name}.sublime-settings".source =
        jsonFormat.generate "sublime-text-settings-${name}" plugin.settings;
    }) (filterAttrs (_: plugin: plugin.settings != { }) cfg.plugins))
    // (concatMapAttrs (
      packageName: plugin:
      concatMapAttrs (name: value: {
        "${configDirectory}/${packageName}/${name}".source = value;
      }) plugin.overrides
    ) (filterAttrs (_: plugin: plugin.overrides != { }) cfg.plugins))
    // (concatMapAttrs (name: build-system: {
      "${userConfigDirectory}/${name}.sublime-build".source =
        jsonFormat.generate "sublime-text-build-${name}" build-system;
    }) cfg.build-systems)
    // (concatMapAttrs (name: syntax: {
      "${userConfigDirectory}/${name}.sublime-syntax".source = syntax;
    }) cfg.syntaxes)
    // (concatMapAttrs (name: snippet: {
      "${userConfigDirectory}/${name}.sublime-snippet".text =
        "
          <snippet>
            <content><![CDATA[${snippet.content}]]></content>
            <tabTrigger>${snippet.tabTrigger}</tabTrigger>
            <scope>${snippet.scope}</scope>
            <description>${snippet.description}</description>
          </snippet>
        ";
    }) cfg.snippets);
  };

  configDirectory = "sublime-text/Packages";
  userConfigDirectory = "${configDirectory}/User";
  jsonFormat = pkgs.formats.json { };

  pluginOptions = types.submodule (_: {
    options = {
      managed = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = ''
          Whether this plugin is managed by Package Control.
        '';
      };
      repository = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "https://github.com/facelessuser/SublimeRandomCrap";
        description = ''
          The repository from which to pull the plugin.
        '';
      };
      settings = mkOption {
        inherit (jsonFormat) type;
        default = { };
        description = ''
          The plugin's settings.
        '';
      };
      overrides = mkOption {
        type = with types; attrsOf path;
        default = { };
        description = ''
          Files to override in a plugin.
        '';
      };
    };
  });
  snippetOptions = types.submodule (_: {
    options = {
      content = mkOption {
        type = types.str;
        example = ''
          Hello, ''${1:this} is a ''${2:snippet}.
        '';
        description = ''
          The content of the snippet.
        '';
      };
      tabTrigger = mkOption {
        type = types.str;
        default = "";
        example = "hello";
        description = ''
          The word that will make the completion appear in the autocompletion.
        '';
      };
      scope = mkOption {
        type = types.str;
        default = "";
        example = "source.python";
        description = ''
          The language scope where the snippet is active.
        '';
      };
      description = mkOption {
        type = types.str;
        default = "";
        description = ''
          A description of the snippet.
        '';
      };
    };
  });
in
{
  options.sublime-text = {
    enable = mkEnableOption "Sublime Text 4";
    package = mkPackageOption pkgs "sublime4" { };

    settings = mkOption {
      inherit (jsonFormat) type;
      default = { };
      example = literalExpression ''
        {
          theme = "Adaptive.sublime-theme";
          color_scheme = "Monokai.sublime-color-scheme";
        }
      '';
      description = ''
        Sublime Text's user settings.
      '';
    };
    font = mkOption {
      type = with types; nullOr str;
      default = null;
    };
    keymap = mkOption {
      inherit (jsonFormat) type;
      default = [ ];
      example = ''
        [
          {
            keys = [ "ctrl+alt+up" ];
            command = "select_lines";
            args.forward = false;
          }
          {
            keys = [ "ctrl+alt+down" ];
            command = "select_lines";
            args.forward = true;
          }
        ]
      '';
    };
    build-systems = mkOption {
      inherit (jsonFormat) type;
      default = { };
    };
    syntaxes = mkOption {
      type = with types; attrsOf path;
      default = { };
    };
    plugins = mkOption {
      type = types.attrsOf pluginOptions;
      example = literalExpression ''
        {
          LSP = {
            lsp_format_on_save = true;
            lsp_code_actions_on_save = {
              "source.fixAll" = true;
              "source.addMissingImports" = true;
              "source.organizeImports" = true;
            };
            show_inlay_hints = true;
            default_clients = {};
            clients = {
              nixd = {
                enabled = true;
                command = [ "nixd" ];
                selector = "source.nix";
              };
            };
          };
        };
      '';
      description = ''
        Installed plugin and their configuration.
      '';
    };
    snippets = mkOption {
      type = types.attrsOf snippetOptions;
      description = ''
        A list of snippets
      '';
    };
  };

  config = lib.mkIf cfg.enable defaultSublime;
}
