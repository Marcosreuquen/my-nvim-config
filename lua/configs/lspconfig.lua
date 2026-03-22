
local nvlsp = require("nvchad.configs.lspconfig")

vim.lsp.config{
  name = "tsserver",
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- settings = { ... } -- sólo si necesitas configuración extra
}

vim.lsp.config{
  name = "eslint",
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  -- settings = { ... } -- sólo si necesitas configuración extra
}
