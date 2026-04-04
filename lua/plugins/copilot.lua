-- Copilot: inline ghost text (like VSCode)
---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = false, -- We handle this manually below
            accept_line = false,
            dismiss = "<C-]>",
            next = "<M-]>",
            prev = "<M-[>",
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
        },
      }

      -- Redraw statusline so the copilot hint stays in sync
      local prev_visible = false
      local function check_and_redraw()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        local visible = ok and suggestion.is_visible() or false
        if visible ~= prev_visible then
          prev_visible = visible
          vim.cmd "redrawstatus"
        end
      end

      vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertEnter" }, {
        callback = function()
          check_and_redraw()
          -- Re-check after debounce to catch delayed suggestions
          vim.defer_fn(check_and_redraw, 100)
        end,
      })

      -- Hide Copilot ghost text while blink.cmp menu is open
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function() vim.b.copilot_suggestion_hidden = true end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function() vim.b.copilot_suggestion_hidden = false end,
      })
    end,
  },
}
