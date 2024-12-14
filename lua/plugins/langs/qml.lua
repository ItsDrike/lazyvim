-- This file adds support for the QML language
-- Note that you will need to have `qmlls6` installed
-- (the package for this is often called something like qt-declarative)

---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          mason = false, -- there is no mason package for qmlls
          cmd = { "qmlls6" },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "qmljs",
      },
    },
  },
}
