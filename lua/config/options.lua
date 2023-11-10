-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = "-"

-- Enable LazyVim autoformat
vim.g.autoformat = true

local opt = vim.opt

opt.wrap = true -- enable line wrapping
-- opt.foldexpr = "nvim_treesitter#foldexpr()" -- set Treesitter based folding
-- opt.foldmethod = "expr"
opt.linebreak = true -- linebreak soft wrap at words
opt.list = true -- show some invisible characters (tabs...)
opt.spell = true -- enable spellcheck
opt.conceallevel = 0 -- disable concealing

opt.listchars = {
  tab = "→ ", -- Tab
  trail = "·", -- Trailing spaces
  extends = "›", -- Character to show in last column when wrap is off and line continues
  precedes = "‹", -- Character to show in first column when there is text preceeding the first visible character
  nbsp = "␣", -- Non-breaking space
}
opt.showbreak = "» " -- String to put at the start of lines that have been wrapped.

vim.g.markdown_fenced_languages = { -- Mappings for markdown fenced languages syntax
  "ts=typescript",
  "py=python",
}
