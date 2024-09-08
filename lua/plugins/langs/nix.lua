-- There is a nix lang extra, however, we don't use it, as it is configured with
-- nil and nixfmt, but I prefer nixd and alejandra. Additionally, I also like
-- using deadnix and statix linters.
--
-- Note that none of these tools (alejandra nixd, deadnix, statix) are available
-- for automatic Mason installation, which means they will need to be made available
-- from $PATH.

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {},
        nil_ls = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = { nix = { "alejandra" } },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { nix = { "deadnix", "statix" } },
    },
  },
}
