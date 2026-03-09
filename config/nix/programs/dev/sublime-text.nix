{ pkgs
, machine-name
, ...
}:
let
  workPlugins =
    if machine-name == "work" then {
      PhpActor = { };
      Phpcs = { };
    } else { };

  workLSPClients =
    if machine-name == "work" then {
      phpactor = {
        enabled = true;
        command = [ "${pkgs.phpactor}/bin/phpactor" "language-server" ];
        selector = "source.php | embedding.php";
        priority_selector = "source.php";
        initialization_options = {
          language_server_completion.trim_leading_dollar = true;
          language_server_worse_reflection.inlay_hints.enable = true;
          language_server_phpstan.enabled = true;
          language_server_phpstan.bin = "${pkgs.phpstan}/bin/phpstan";
        };
      };
    } else { };

  personnalLSPClients =
    if machine-name != "work" then
      {
        qmlls = {
          enabled = true;
          command = [ "${pkgs.kdePackages.qtdeclarative}/bin/qmlls" ];
          selector = "source.qml";
        };
      } else { };

  personnalPlugins =
    if machine-name != "work" then {
      LSP-lua = { };
      LSP-pylsp = { };
      LSP-ruff = { };
      LSP-rust-analyzer = {
        settings = {
          settings = {
            rust-analyzer = {
              checkOnSave = true;
              check = {
                command = "clippy";
                extraArgs = [
                  "--"
                  "-W"
                  "clippy::pedantic"
                  "-W"
                  "clippy::cargo"
                  "-W"
                  "clippy::nursery"
                  "-W"
                  "clippy::alloc_instead_of_core"
                  "-W"
                  "missing_debug_implementations"
                  "-W"
                  "clippy::expect_used"
                  "-A"
                  "clippy::cast_lossless"
                  "-A"
                  "clippy::redundant_else"
                ];
              };
            };
          };
        };
      };
      QML = { };
    } else { };

  defaultPlugins = {
    "A File Icon" = { };
    BracketHighlighter = {
      settings = {
        ignore_threshold = false;
      };
    };
    "Color Scheme - Dracula Neue" = { };
    "Dracula Color Scheme" = { };
    LSP = {
      settings = {
        lsp_code_actions_on_save = {
          source = {
            addMissingImports = true;
            fixAll = true;
            organizeImports = true;
          };
        };
        lsp_format_on_save = true;
        show_inlay_hints = true;
        clients = {
          nixd = {
            enabled = true;
            command = [ "${pkgs.nixd}/bin/nixd" ];
            selector = "source.nix";
            settings.nixd.formatting.command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          };
        } // personnalLSPClients // workLSPClients;
      };
    };
    LSP-bash = { };
    LSP-clangd = { };
    LSP-css = { };
    LSP-html = { };
    LSP-json = { };
    LSP-typescript = { };
    LSP-yaml = { };
    Nushell = { };
    "Package Control" = { };
    TOML = { };
    Nix = { };
  };
in
{
  imports = [
    ../../../../modules/nix/sublime-text.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  sublime-text = {
    enable = true;
    plugins = { } // defaultPlugins // workPlugins // personnalPlugins;
    keymap = [
      {
        keys = [ "f2" ];
        command = "lsp_symbol_rename";
        context = [
          {
            key = "lsp.session_with_capability";
            operand = "renameProvider";
          }
        ];
      }
      {
        keys = [ "ctrl+." ];
        command = "lsp_code_actions";
        context = [
          {
            key = "lsp.session_with_capability";
            operand = "codeActionProvider";
          }
        ];
      }
    ];
    snippets = { };
    settings = {
      font_face = "FiraCode Nerd Font Mono";
      ignored_packages = [
        "Vintage"
      ];
      index_files = false;
      font_size = 17;
      added_words = [
        "fzf"
        "toml"
      ];
      theme = "Default Dark.sublime-theme";
      color_scheme = "Dracula Neue Classic.sublime-color-scheme";
    };
  };
}
