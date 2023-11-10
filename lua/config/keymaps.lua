-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Also load abbreviations
require("config.abbreviations")

local map = vim.keymap.set

-- Use \ for splitting below (not -), and don't prefix the map with leader
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>w-")
map("n", "|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "\\", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w\\", "<C-W>s", { desc = "Split window below", remap = true })

-- Delete to void register & paste without overriding copied text
map("n", "<A-d>", '"_d')
map("v", "<A-d>", '"_d')
map("v", "<A-p>", '"_dP')

-- Quick word replacing (allowing . for next word replace)
map("n", "cn", "*``cgn")
map("n", "cN", "*``cgN")

-- better increment/decrement
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Descrement number" })
map("x", "+", "g<C-a>", { desc = "Increment number" })
map("x", "-", "g<C-x>", { desc = "Descrement number" })

-- Replicate Ctrl+A as it is in most editors
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
