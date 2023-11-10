return {
  {
    "neo-tree.nvim",
    keys = { { "<C-n>", "<leader>e", desc = "Explorer NeoTree (root dir)", remap = true } },
    opts = {
      filtered_items = {
        always_show = {
          ".github",
          ".gitignore",
          ".env",
          ".pre-commit-config.yaml",
          ".flake8",
          ".gitlab-ci",
          "TODO",
        },
      },
      commands = {
        system_open = function(state)
          -- TODO: just use vim.ui.open when dropping support for Neovim <0.10
          (vim.ui.open or require("astronvim.utils").system_open)(state.tree:get_node():get_id())
        end,
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == "directory" or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
            state.commands.open(state)
          end
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ""
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            require("utils").notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item)
              return ("%s: %s"):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              require("utils").notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,
        find_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files({
            cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
          })
        end,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = false,
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          F = "find_in_dir",
          O = "system_open",
          Y = "copy_selector",
          h = "parent_or_close",
          l = "child_or_open",
          o = "open",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
          end,
        },
      },
    },
  },

  -- Override which-key category names (add icons and new categories)
  -- and register any queued mappings, defined from plugins.
  {
    "which-key.nvim",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
      require("utils.keymaps").which_key_register()
    end,
  },

  -- Highlight function arguments
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
  },

  -- Git diff
  {
    "sindrets/diffview.nvim",
    event = "User CustomGitFile",
    opts = function()
      local actions = require("diffview.actions")
      local utils = require("utils")

      local prefix = "<leader>gd"

      require("utils.keymaps").set_mappings({
        n = {
          [prefix] = { name = " Diff View" },
          [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
          [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History" },
          [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
        },
      })

      -- Build a list of keymap definitions for a view
      -- This function already includes the default keymaps, which should be present in all views
      -- and only extends these by the passed maps.
      local build_keymaps = function(maps)
        local out = {}
        local i = 1
        for lhs, def in
          pairs(utils.extend_tbl(maps, {
            [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Toggle the file panel.
            ["]D"] = { actions.select_next_entry, desc = "Next Difference" }, -- Open the diff for the next file
            ["[D"] = { actions.select_prev_entry, desc = "Previous Difference" }, -- Open the diff for the previous file
            ["[C"] = { actions.prev_conflict, desc = "Next Conflict" }, -- In the merge_tool: jump to the previous conflict
            ["]C"] = { actions.next_conflict, desc = "Previous Conflict" }, -- In the merge_tool: jump to the next conflict
            ["Cl"] = { actions.cycle_layout, desc = "Cycle Diff Layout" }, -- Cycle through available layouts.
            ["Ct"] = { actions.listing_style, desc = "Cycle Tree Style" }, -- Cycle through available layouts.
            ["<leader>e"] = { actions.toggle_files, desc = "Toggle Explorer" }, -- Toggle the file panel.
            ["<leader>o"] = { actions.focus_files, desc = "Focus Explorer" }, -- Bring focus to the file panel
          }))
        do
          local opts
          local rhs = def
          local mode = { "n" }
          if type(def) == "table" then
            if def.mode then
              mode = def.mode
            end
            rhs = def[1]
            def[1] = nil
            def.mode = nil
            opts = def
          end
          out[i] = { mode, lhs, rhs, opts }
          i = i + 1
        end
        return out
      end

      return {
        enhanced_diff_hl = true,
        view = {
          merge_tool = { layout = "diff3_mixed" },
        },
        keymaps = {
          disable_defaults = true,
          view = build_keymaps({
            [prefix .. "o"] = { actions.conflict_choose("ours"), desc = "Take Ours" }, -- Choose the OURS version of a conflict
            [prefix .. "t"] = { actions.conflict_choose("theirs"), desc = "Take Theirs" }, -- Choose the THEIRS version of a conflict
            [prefix .. "b"] = { actions.conflict_choose("base"), desc = "Take Base" }, -- Choose the BASE version of a conflict
            [prefix .. "a"] = { actions.conflict_choose("all"), desc = "Take All" }, -- Choose all the versions of a conflict
            [prefix .. "0"] = { actions.conflict_choose("none"), desc = "Take None" }, -- Delete the conflict region
          }),
          diff3 = build_keymaps({
            [prefix .. "O"] = { actions.diffget("ours"), mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget("theirs"), mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          }),
          diff4 = build_keymaps({
            [prefix .. "B"] = { actions.diffget("base"), mode = { "n", "x" }, desc = "Get Base Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "O"] = { actions.diffget("ours"), mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget("theirs"), mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          }),
          file_panel = build_keymaps({
            j = actions.next_entry, -- Bring the cursor to the next file entry
            k = actions.prev_entry, -- Bring the cursor to the previous file entry.
            o = actions.select_entry,
            S = actions.stage_all, -- Stage all entries.
            U = actions.unstage_all, -- Unstage all entries.
            X = actions.restore_entry, -- Restore entry to the state on the left side.
            L = actions.open_commit_log, -- Open the commit log panel.
            Cf = { actions.toggle_flatten_dirs, desc = "Flatten" }, -- Flatten empty subdirectories in tree listing style.
            R = actions.refresh_files, -- Update stats and entries in the file list.
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          }),
          file_history_panel = build_keymaps({
            j = actions.next_entry,
            k = actions.prev_entry,
            o = actions.select_entry,
            y = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            L = actions.open_commit_log,
            zR = { actions.open_all_folds, desc = "Open all folds" },
            zM = { actions.close_all_folds, desc = "Close all folds" },
            ["?"] = { actions.options, desc = "Options" }, -- Open the option panel
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          }),
          option_panel = {
            q = actions.close,
            o = actions.select_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse"] = actions.select_entry,
          },
        },
      }
    end,
  },

  -- Undo tree in telescope
  {
    "telescope.nvim",
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>su", "<cmd>Telescope undo<CR>", desc = "Undo History" } },
        config = function()
          require("utils").on_load("telescope.nvim", function()
            require("telescope").load_extension("undo")
          end)
        end,
      },
    },
  },
}
