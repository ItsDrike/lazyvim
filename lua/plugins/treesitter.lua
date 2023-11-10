return {
  -- add more treesitter parsers
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      -- Except these
      --ignore_install = { "html" }
    },
  },

  -- View treesitter information directly in Neovim
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSHighlightCapturesUnderCursor",
      "TSPlaygroundToggle",
    },
    dependencies = { "nvim-treesitter" },
  },
}
