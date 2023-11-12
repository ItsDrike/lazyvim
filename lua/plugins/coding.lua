return {
  -- Use <C-n> and <C-p> instead of <tab> and <s-tab> for snippets jumps
  {
    "LuaSnip",
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
      {
        "<C-n>",
        function()
          local luasnip = require("luasnip")
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<C-p>",
        function()
          local luasnip = require("luasnip")
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end,
        mode = { "i", "s" },
      },
    },
  },

  -- Add more cmp sources and manage their priorities
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc", -- Quick calculator as completion source
      "f3fora/cmp-spell", -- Complation based on the words in spell list
      "hrsh7th/cmp-emoji", -- Emojis
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.sources = {
        { name = "crates", priority = 1100 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "copilot", priority = 600 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "calc", priority = 100 },
        { name = "emoji", priority = 50 },
        { name = "spell", priority = 25 },
      }
    end,
  },

  -- Override cmp mappings, don't use tab for item selection, prefer <C-k> and <C-j>
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Helper function, checking if there are any words before cursor
      -- (This is copied from AstroNvim source)
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- Disable <C-n> and <C-p> mappings for cmp item selecting, they're used for luasnip
      opts.mapping["<C-n>"] = nil
      opts.mapping["<C-p>"] = nil

      -- Use <C-j> and <C-k> for selecting cmp items
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      opts.mapping["<C-j>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          -- <C-j> will also start a completion, if not visible
          cmp.complete()
        end
      end, { "i", "s" })

      -- Use <Tab> purey for confirming a selected cmp item.
      -- Don't use it for jumping to next luasnip location (there's <C-n>)
      -- Don't use it for selecting next cmp item (there's <C-j>)
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" })

      -- Entirely unmap <S-Tab>.
      -- We no longer need it for jumping to previous luasnip location (there's <C-p>)
      -- We no longer need it for selecting previous cmp item (there's <C-k>)
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        fallback()
      end, { "i", "s" })

      -- Override <CR> to only confirm explicitly selected items
      -- This allows us to press enter to go to next line, even with completion window
      -- open, unless we explicitly selected something (<C-j>/<C-k>), then it confirms.
      -- There's <Tab> for confirmation anyway, so don't override enter
      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })
    end,
  },

  -- Disable mini.pairs in favor of nvim-autopairs
  {
    "mini.pairs",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "User CustomFile",
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false }))
      end
    end,
  },

  -- Code time & habit tracking
  {
    "wakatime/vim-wakatime",
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "WakaTimeApiKey",
      "WakaTimeDebugEnable",
      "WakaTimeDebugDisable",
      "WakaTimeScreenRedrawEnable",
      "WakaTimeScreenRedrawEnableAuto",
      "WakaTimeScreenRedrawDisable",
      "WakaTimeToday",
      "WakaTimeCliLocation",
      "WakaTimeCliVersion",
      "WakaTimeFileExpert",
    },
  },
}
