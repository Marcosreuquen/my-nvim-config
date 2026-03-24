-- Transparencia en ventana de terminal
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.opt_local.winhl = "Normal:Normal,NormalNC:NormalNC"
  end,
})

-- Bloquear ventanas de terminal y NvimTree para que no se reutilicen
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "terminal" or vim.bo.filetype == "NvimTree" then
      vim.wo.winfixbuf = true
    end
  end,
})

-- :Format — usa conform.nvim, soporta rango visual
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

-- :Eslint — ejecuta EslintFixAll (buffer completo) o code_action en rango visual
vim.api.nvim_create_user_command("Eslint", function(args)
  if args.count ~= -1 then
    -- Rango visual: aplica code actions de eslint en la selección
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll.eslint" } },
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, 0 },
      },
    })
  else
    vim.cmd("EslintFixAll")
  end
end, { range = true, desc = "Run ESLint fix on buffer or visual selection" })
