---@type LazySpec
return {
  -- Add keys to search through ignored files too (hidden/gitignored)
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fh", LazyVim.pick("files", { no_ignore = true }), desc = "Find All Files (root dir)" },
      { "<leader>fH", LazyVim.pick("files", { root = false, no_ignore = true }), desc = "Find All Files (cwd)" },
    },
  },
}
