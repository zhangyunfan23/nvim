-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

keymap.set("i", "jj", "<Esc>")
-- Use <C-s> for save to avoid conflicting with LazyVim's <leader>w window prefix
keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<CR>", { silent = true })
keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
