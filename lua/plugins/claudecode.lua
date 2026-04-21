-- Claude Code nvim integration
---@type LazySpec
return {
  {
    "coder/claudecode.nvim",
    lazy = false,
    dependencies = { "folke/snacks.nvim" },
    ---@type ClaudeCodeConfig
    opts = {
      auto_start = true,
      track_selection = true,
      focus_after_send = false,
      split_side = "right",
      split_width_percentage = 0.35,
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Set Enter/Delete as diff accept/deny in Claude diff buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "ClaudeCodeDiff",
        callback = function(ev)
          local buf = ev.buf
          vim.keymap.set("n", "<CR>",  "<cmd>ClaudeCodeDiffAccept<CR>", { buffer = buf, desc = "Accept Claude diff" })
          vim.keymap.set("n", "<Del>", "<cmd>ClaudeCodeDiffDeny<CR>",   { buffer = buf, desc = "Reject Claude diff" })
          vim.keymap.set("n", "<BS>",  "<cmd>ClaudeCodeDiffDeny<CR>",   { buffer = buf, desc = "Reject Claude diff" })
        end,
      })
    end,
    keys = {
      -- Toggle: espeja <C-.> de opencode
      { "<C-,>", "<cmd>ClaudeCodeFocus<CR>",       desc = "Toggle Claude Code",         mode = { "n", "t" } },
      -- Enviar seleccion a Claude
      { "<leader>as", "<cmd>ClaudeCodeSend<CR>",   desc = "AI: Send to Claude",         mode = { "n", "v" } },
      -- Agregar archivo actual al contexto
      { "<leader>ac", "<cmd>ClaudeCodeAdd %<CR>",  desc = "AI: Add file to Claude",     mode = "n" },
      -- Agregar archivo seleccionado en neo-tree
      { "<leader>at", "<cmd>ClaudeCodeTreeAdd<CR>",desc = "AI: Add tree file to Claude",mode = "n" },
      -- Seleccionar modelo
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "AI: Select Claude model", mode = "n" },
    },
  },
}
