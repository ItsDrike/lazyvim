-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

----------------------------------------------------------------------------------------------
---Keymaps
----------------------------------------------------------------------------------------------

-- Use <C-n> for NeoTree toggle (I'm more used to this than the default <leader>e)
map("n", "<C-n>", "<leader>e", { remap = true, desc = "Explorer NeoTree (Root Dir)" })

-- Quick word replacing (allowing . for next word replace)
map("n", "cn", "*``cgn", { desc = "Replace word, repeating below" })
map("n", "cN", "*``cgn", { desc = "Replace word, repeating above" })

-- Intuitive increment/decrement
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("x", "+", "g<C-a>", { desc = "Increment number" })
map("x", "-", "g<C-x>", { desc = "Decrement number" })

-- Select all text
map("n", "<C-a>", "<gg<S-v>G", { desc = "Select all" })

-- Quick window splitting
map("n", "|", "<leader>|", { remap = true, desc = "Split Window Right" })
map("n", "\\", "<leader>-", { remap = true, desc = "Split Window Below" })

-- I'm used to opening diagnostic float with gl, instead of <C-w>d or <leader>cd
map("n", "gl", "<leader>cd", { remap = true, desc = "Line diagnostics" })

-- Move lines up and down
map("n", "<C-S-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
map("n", "<C-S-k>", "<Esc>:m .-2<CR>==", { desc = "Move line up", silent = true })
map("i", "<C-S-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down", silent = true })
map("i", "<C-S-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up", silent = true })
map("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up", silent = true })
map("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down", silent = true })

----------------------------------------------------------------------------------------------
---Keymaps
----------------------------------------------------------------------------------------------

---Define an abbreviations
---@param mode "c"|"i"|"!"
---@param input string
---@param result string
---@param reabbrev? boolean false by default
local function abbrev(mode, input, result, reabbrev)
  --HACK: There's no built-in lua API for defining abbreviations, do it through vim.cmd
  --TODO: Once nvim 0.10 comes out, mappings will support abbrevs with ca,ia,!a modes. See:
  -- https://github.com/neovim/neovim/pull/23803/files
  reabbrev = reabbrev or false

  local command
  if reabbrev then
    command = mode .. "abbrev"
  else
    command = mode .. "noreabbrev"
  end

  vim.cmd(command .. " " .. input .. " " .. result)
end

-- Invalid case abbreviations
abbrev("c", "Wq", "wq")
abbrev("c", "wQ", "wq")
abbrev("c", "WQ", "wq")
abbrev("c", "W", "w")
abbrev("c", "Q", "q")
abbrev("c", "W!", "w!")
abbrev("c", "Q!", "q!")
abbrev("c", "Qall", "qall")
abbrev("c", "Qall!", "qall!")
abbrev("c", "QALL", "qall")
abbrev("c", "QALL", "qall!")

-- Save file with sudo
abbrev("c", "w!!", "w !sudo tee >/dev/null %")
