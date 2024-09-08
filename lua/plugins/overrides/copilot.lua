---@type LazySpec
return {
  -- Add a keybinding for quickly toggling copilot on/off
  "zbirenbaum/copilot.lua",
  keys = {
    {
      "<leader>at",
      "<cmd>Copilot toggle<CR>",
      desc = "Toggle copilot autocompletions",
      mode = { "n", "v" },
    },
  },
}
