return {
  -- Copilot inline ghost text (like VSCode)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-k>",
            accept_line = "<M-j>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          ["*"] = true,
        },
        server = {
          type = "binary",
        }
      })

      -- Redraw statusline so the copilot hint stays in sync
      local prev_visible = false
      local function check_and_redraw()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        local visible = ok and suggestion.is_visible() or false
        if visible ~= prev_visible then
          prev_visible = visible
          vim.cmd("redrawstatus")
        end
      end

      vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertEnter" }, {
        callback = function()
          check_and_redraw()
          -- Re-check after debounce to catch delayed suggestions
          vim.defer_fn(check_and_redraw, 100)
        end,
      })
    end,
  },
}
