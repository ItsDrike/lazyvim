---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    optional = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        list = {
          selection = { preselect = false, auto_insert = false },
        },
      },
      --signature = { enabled = true },
      keymap = {
        -- Disable any pre-sets, I like to configure this from scratch
        --
        -- This is because I don't like the default behavior, where <CR> is used to confirm the
        -- completions whenever available. This is because I often just want a newline, but a
        -- completion is started, and I accidentally select something, which is very annoying.
        -- I only want to use <CR> for confirming if something was explicitly selected.
        --
        -- I also don't like that <Tab> is used to handle snippet jumping, since that means I
        -- can't use tab to actually tab while in a completion. I prefer using a completely
        -- different keymap for snippet jumping and only snippet jumping.
        --
        -- On top of this, I like to select the completions with <C-j> & <C-k>, not <Tab>.
        --
        -- This means that none of the available presets are a great fit for me.
        preset = "none",

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<C-j>"] = { "show", "select_next", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },

        ["<Tab>"] = { "accept", "fallback" }, -- accept only if explicitly selected
        ["<CR>"] = { "accept", "fallback" }, -- accept only if explicitly selected
        ["<S-Tab"] = { "hide", "fallback" },

        ["<C-n>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        --["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
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
    optional = true,
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
