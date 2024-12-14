---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { width = 30 },
      filesystem = {
        group_empty_dirs = true,
      },
    },
  },
}
