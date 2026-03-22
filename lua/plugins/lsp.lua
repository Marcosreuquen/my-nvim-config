return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local nvlsp = require "nvchad.configs.lspconfig"

      vim.lsp.config("tsserver", {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      vim.lsp.config("eslint", {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      })
    end,
  },
}
