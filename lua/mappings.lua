require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Copilot Chat
map({ "n", "i", "v" }, "<C-c>", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })

