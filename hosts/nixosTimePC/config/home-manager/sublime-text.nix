{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = {
      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
  }; # double fuck
in
{
  imports = [
    ../../../../modules/home-manager/sublime-text.nix
  ];

  sublime-text = {
    enable = true;
    package =
      let
        unwrapped = pkgs.sublime4.unwrapped.overrideAttrs (
          _final: previous: {
            buildPhase =
              lib.replaceStrings
                [ "--set-rpath " ]
                [
                  "--set-rpath ${lib.makeLibraryPath [ pkgs-stable.openssl_1_1 ]}:"
                ]
                previous.buildPhase;
          }
        );
      in
      pkgs.sublime4.overrideAttrs (
        _final: previous: {
          installPhase =
            lib.replaceStrings [ "${pkgs.sublime4.unwrapped}" ] [ "${unwrapped}" ]
              previous.installPhase;
        }
      ); # fuck this
    plugins = {
      "Language - French - Français" = { };
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
            qmlls = {
              enabled = true;
              command = [ "${pkgs.kdePackages.qtdeclarative}/bin/qmlls" ];
              selector = "source.qml";
            };
            phpantom = {
              enabled = true;
              command = [ "${pkgs.phpantom-lsp}/bin/phpantom_lsp" ];
              selector = "source.php";
              settings.phpantom.formatting.command = [ "${pkgs.mago}/bin/mago format" ];
            };
          };
        };
      };
      LSP-bash = { };
      LSP-clangd = { };
      LSP-css = { };
      LSP-html = { };
      LSP-json = { };
      LSP-typescript = { };
      LSP-yaml = { };
      "Package Control" = { };
      TOML = { };
      Nix = { };
      LSP-lua = { };
      LSP-pylsp = { };
      LSP-ruff = { };
      LSP-rust-analyzer = {
        settings = {
          command = [ "${pkgs.rustup}/bin/rust-analyzer" ];
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
    };
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
    snippets = {
      submodule = {
        content = ''
          lib.types.submodule {
            options = {
              $1
            };
          };
        '';
        tabTrigger = "submodule";
        scope = "source.nix";
      };

      mkOption = {
        content = ''
          lib.mkOption {
            type = $1;
            default = $2;
          };
        '';
        tabTrigger = "mkOption";
        scope = "source.nix";
      };

      int = {
        content = ''
          lib.types.int
        '';
        tabTrigger = "int";
        scope = "source.nix";
      };

      str = {
        content = ''
          lib.types.str
        '';
        tabTrigger = "str";
        scope = "source.nix";
      };

      listOf = {
        content = ''
          lib.types.listOf
        '';
        tabTrigger = "listOf";
        scope = "source.nix";
      };

      bool = {
        content = ''
          lib.types.bool
        '';
        tabTrigger = "bool";
        scope = "source.nix";
      };

      float = {
        content = ''
          lib.types.float
        '';
        tabTrigger = "float";
        scope = "source.nix";
      };
    };
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
      spell_check = true;
      dictionary = [
        "Packages/Language - English/en_US.dic"
        "Packages/Language - French - Français/fr_FR.dic"
      ];
    };
  };
}
