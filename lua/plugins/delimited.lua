---@type LazySpec
return {
  -- Visually highlight the range of diagnostic
  {
    "mizlan/delimited.nvim",
    keys = {
      {
        "[d",
        function()
          require("delimited").goto_prev()
        end,
        desc = "Prev Diagnostic",
      },
      {
        "]d",
        function()
          require("delimited").goto_next()
        end,
        desc = "Next Diagnostic",
      },
      {
        "[e",
        function()
          require("delimited").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Prev Error",
      },
      {
        "]e",
        function()
          require("delimited").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Next Error",
      },
      {
        "[w",
        function()
          require("delimited").goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Prev Warning",
      },
      {
        "]e",
        function()
          require("delimited").goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Next Warning",
      },
    },
  },
}
