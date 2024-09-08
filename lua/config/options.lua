-- Options are automatically loaded before lazy.nvim startup (by plugins.core)
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-----------------------------------------------------------------------------------------------------
---LazyVim options
-----------------------------------------------------------------------------------------------------

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "auto"

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- LazyVim automatically configures lazygit:
--  * theme, based on the active colorscheme.
--  * editPreset to nvim-remote
--  * enables nerd font icons
-- Set to false to disable.
-- Set the options you want to override in `~/.config/lazygit/custom.yml`
vim.g.lazygit_config = true

-- Options for the LazyVim statuscolumn
vim.g.lazyvim_statuscolumn = {
  folds_open = false, -- show fold sign when fold is open
  folds_githl = false, -- highlight fold sign with git sign color
}

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-----------------------------------------------------------------------------------------------------
---Vim options
-----------------------------------------------------------------------------------------------------

vim.opt.wrap = true
vim.opt.relativenumber = true
vim.opt.spell = true
vim.opt.listchars = {
  tab = " ", -- Tab
  trail = "·", -- Trailing spaces
  nbsp = "␣", -- Non-breaking space
  extends = "⟩", -- Character to show in last column when wrap is off and line continues
  precedes = "⟨", -- Character to show in first column when there is text preceeding the first visible character
}
vim.opt.showbreak = "»" -- String to put at the start of lines that have been wrapped.

-----------------------------------------------------------------------------------------------------
---Extras options
-----------------------------------------------------------------------------------------------------

-- Python extra:
---- Use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Prettier extra
--- Require prettier config file to run it as a formatter
vim.g.lazyvim_prettier_needs_config = false
