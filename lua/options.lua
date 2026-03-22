require "nvchad.options"

-- add yours here!

vim.opt.foldmethod = "expr"               -- Usa una expresión para el plegado
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Usa Treesitter como método de plegado
vim.opt.foldenable = true                 -- Activa el plegado por defecto
vim.opt.foldlevel = 99                    -- Mantiene el código expandido al abrir un archivo
vim.opt.foldlevelstart = 99
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--

--function _G.custom_foldtext()
--        return "+"
--end

--vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.cmd([[highlight Folded guifg=#D4A6FF guibg=NONE gui=bold]])  -- Violeta claro sobre fondo oscuro

-- Mantener transparencia en ventana de terminal incluso cuando está activa/enfocada
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.opt_local.winhl = "Normal:Normal,NormalNC:NormalNC"
  end,
})

-- Bloquear ventanas de terminal y NvimTree para que no se reutilicen al abrir archivos
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local bt = vim.bo.buftype
    if bt == "terminal" or vim.bo.filetype == "NvimTree" then
      vim.wo.winfixbuf = true
    end
  end,
})


