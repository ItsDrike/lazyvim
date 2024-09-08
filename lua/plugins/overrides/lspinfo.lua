---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Notify me about LSP formatting the file
      format_notify = true,
      -- Disable inlay hints, they just get in the way
      -- if I want to know the type, I can just use `K`
      inlay_hints = { enabled = false },

      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          -- "icons" triggers a custom handler in LazyVim, that sets prefix to the
          -- appropriate icon, depending on the diagnostic severity
          prefix = "icons",

          -- Don't include the source in virtual text, it takes precious horizontal space
          source = false,
        },
        -- Always include the diagnostic source in the message (default is "if_many")
        float = { source = true },
      },
    },
  },
}
