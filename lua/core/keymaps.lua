require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Copilot Chat
map({ "n", "i", "v" }, "<C-c>", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })
