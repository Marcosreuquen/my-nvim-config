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
