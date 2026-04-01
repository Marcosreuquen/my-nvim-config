require "nvchad.options"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.winborder = 'rounded'

vim.cmd [[highlight Folded guifg=#D4A6FF guibg=NONE gui=bold]]
