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
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Make the Claude terminal window transparent like the rest of the UI
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*claude*",
        callback = function()
          vim.wo.winhighlight = "Normal:Normal,NormalFloat:Normal,FloatBorder:WinSeparator"
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
