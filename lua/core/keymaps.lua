require "nvchad.mappings"

-- Remove NvChad default that copies entire file on C-c
vim.keymap.del("n", "<C-c>")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Lsp
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<C-z>", "<cmd>undo<CR>", { desc = "Undo last change" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo last change" })
