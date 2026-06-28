{
  ...
}:
{
  imports = [ ../../../modules/home-manager/lazyvim.nix ];

  lazyvim.enable = true;
  # programs.lazyvim = {
  #   enable = true;
  #   extras = {
  #     lang = {
  #       rust.enable = true;
  #       nix.enable = true;
  #     };
  #   };
  #   config = {
  #     autocmds = ''
  #       vim.cmd([[cnoreabbrev q qall]])
  #     '';
  #   };
  #   plugins = {
  #     formatting = ''
  #       return {
  #         "stevearc/conform.nvim",
  #         optional = true,
  #         opts = {
  #           formatters_by_ft = {
  #             rust = { "cargo fmt" },
  #             nix = { "nixfmt", "statix" },
  #           },
  #         },
  #       }
  #     '';
  #   };
  # };
}
