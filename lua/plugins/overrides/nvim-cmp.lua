---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- I dislike the usual behavior where <Tab> does way too much.
      -- I don't want tab to handle starting completions nor scrolling in completions,
      -- but I especially dislike it handling snippet jumping, since it means I can't use
      -- tab to actually tab. The only use of tab should be to confirm a completion, if available.
      --
      -- Similarly, I don't like <CR> confirming the completion automatically whenever available,
      -- I often just want a newline, but a completion started, and now I accidentally selected
      -- something. Instead, only use <CR> to confirm a completion if it was explicitly selected.
      -- Otherwise, only <Tab> can be used to confirm without explicit selection.
      --
      -- I override all the cmp mappings to use my preferred way to control cmp, that is:
      -- * <C-j> to start a completion, or pick the next item
      -- * <C-k> to pick the previous item
      -- * <C-n> to handle snippet jumping (next)
      -- * <C-p> to handle snippet jumping (prev)
      -- * <Tab> to confirm a completion
      -- * <CR> to confirm a completion, if something was explicitly selected
      -- * <S-Tab> to abort a completion, if active
      opts.mapping = cmp.mapping.preset.insert({
        -- Only use <Tab> to confirm completions
        ["<Tab>"] = cmp.mapping(LazyVim.cmp.confirm({ select = true }), { "i", "s" }),

        -- Only use <S-Tab> to abort an active completion
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.close()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Use <CR> to confirm a completion if visible (equivalent to <Tab>)
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if LazyVim.cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = LazyVim.cmp.confirm({ select = true }),
        }),

        -- Use <C-j> to handle starting the completion and selecting the next item
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end, { "i", "s" }),

        -- Use <C-k> to handle selecting the previous item
        ["<C-k>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end
        end),

        -- Use <C-n> to jump to the next position in a snippet
        ["<C-n>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Use <C-p> to jump to the previous position in a snippet
        ["<C-p>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Docs scrolling (this is also the default)
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      })
    end,

    -- Unmap <Tab> and <S-Tab> keys, which were overwritten here for snippets
    -- I don't like handling snippets with tabs, I prefer <C-n> & <C-p>, as configured in cmp mapping opts (above).
    keys = {
      { "<Tab>", mode = { "i", "s" }, false },
      { "<S-Tab>", mode = { "i", "s" }, false },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
