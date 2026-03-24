return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local nvlsp = require "nvchad.configs.lspconfig"

      vim.lsp.config("*", {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.lsp.config("ts_ls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      })

      vim.lsp.enable({
        "lua_ls",
        "eslint",
        "ts_ls",
        "volar",
        "pyright",
        "bashls",
      })
    end,
  },
}
