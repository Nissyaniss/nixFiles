{ pkgs
, ...
}:

{
  imports = [
    ../../../../modules/nix/sublime-text.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  sublime-text = {
    enable = true;
    plugins = {
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
          clients.nixd = {
            enabled = true;
            command = [ "${pkgs.nixd}/bin/nixd" ];
            selector = "source.nix";
            settings.nixd.formatting.command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          };
        };
      };
      LSP-bash = { };
      LSP-clangd = { };
      LSP-css = { };
      LSP-html = { };
      LSP-intelephense = { };
      LSP-jdtls = { };
      LSP-json = { };
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
      LSP-typescript = { };
      LSP-yaml = { };
      Nushell = { };
      "Package Control" = { };
      # SQLTools = { };
      # Terminal = { };
      TOML = { };
      Nix = { };
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
            operand = "codeActionProvider.codeActionKinds";
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
