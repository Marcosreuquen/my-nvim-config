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

-- Copilot Chat higlights
vim.cmd([[highlight CopilotChatHeader guifg=#D4A6FF guibg=NONE gui=bold]])
vim.cmd([[highlight CopilotChatSeparator guifg=#D4A6FF guibg=NONE gui=bold]])

