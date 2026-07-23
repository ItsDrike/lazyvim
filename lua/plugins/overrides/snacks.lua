---@type LazySpec
return {
  "folke/snacks.nvim",
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    -- Faster scroll animation
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 15, total = 150 },
        easing = "inOutCubic",
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 500, -- delay in ms before using the repeat animation
        duration = { step = 5, total = 50 },
        easing = "linear",
      },
    },
  },
}
