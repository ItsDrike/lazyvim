-- Disable using Mason for various language servers, linters, formatters or other tools.
-- I prefer just having these in $PATH, managed by my package manager.
--
-- Required executables in $PATH:
-- Language servers:
--  * ruff
--  * basedpyright
--  * lua-language-server
--  * taplo
--  * gopls
--  * marksman
--  * yaml-language-server
--  * nil
--  * neocmakelsp
--  * bash-language-server
--  * emmet-language-server
-- Linters & Formatters:
--  * stylua
--  * shfmt
--  * gofumpt
--  * goimports (gotools)
--  * sqlfluff
--  * hadolint
--  * markdownlint-cli2
--  * prettier
--  * shellcheck
--  * shfmt
--
--  Note that not every tool has mason disabled, because some of the tools aren't shipped
--  by my package manager, and it would be a hassle to manage them manually. That said, it
--  isn't ideal to use Mason either, since the built binaries can break after a system update
--  due to dynamic linking on NixOS.

---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = { mason = false },
        ruff = { mason = false },
        lua_ls = { mason = false },
        taplo = { mason = false },
        gopls = { mason = false },
        marksman = { mason = false },
        yamlls = { mason = false },
        nil_ls = { mason = false },
        neocmake = { mason = false },
        bashls = { mason = false },
        emmet_language_server = { mason = false },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      local remove_value = require("utils").remove_value

      remove_value(opts.ensure_installed, "stylua")
      remove_value(opts.ensure_installed, "shfmt")
      remove_value(opts.ensure_installed, "gofumpt")
      remove_value(opts.ensure_installed, "goimports")
      remove_value(opts.ensure_installed, "sqlfluff")
      remove_value(opts.ensure_installed, "markdownlint-cli2")
      remove_value(opts.ensure_installed, "prettier")
      remove_value(opts.ensure_installed, "shellcheck")
      remove_value(opts.ensure_installed, "shfmt")
    end,
  },
}
