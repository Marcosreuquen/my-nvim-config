-- This will run last in the setup process.
-- Custom autocommands, user commands, and other polish.

-- Terminal transparency
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.opt_local.winhl = "Normal:Normal,NormalNC:NormalNC"
  end,
})

-- Lock terminal and neo-tree windows so they cannot be reused for other buffers
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "terminal" or vim.bo.filetype == "neo-tree" then
      vim.wo.winfixbuf = true
    end
  end,
})

-- :Format — uses conform.nvim, supports visual range
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line[1]:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true, desc = "Format buffer or visual selection" })

-- :Eslint — runs EslintFixAll (full buffer) or code_action on visual range
vim.api.nvim_create_user_command("Eslint", function(args)
  if args.count ~= -1 then
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll.eslint" } },
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, 0 },
      },
    })
  else
    vim.cmd "EslintFixAll"
  end
end, { range = true, desc = "Run ESLint fix on buffer or visual selection" })

-- :NotificationHistory — show Snacks notification history
vim.api.nvim_create_user_command("NotificationHistory", function()
  require("snacks").notifier.show_history()
end, { desc = "Show notification history" })

-- Fold highlight
vim.cmd [[highlight Folded guifg=#D4A6FF guibg=NONE gui=bold]]
