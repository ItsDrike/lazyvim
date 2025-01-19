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

  -- Add telescope undo plugin for proper undo tree
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>su",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "Show Undo Tree",
      },
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("undo")
      end)
    end,
  },
}
