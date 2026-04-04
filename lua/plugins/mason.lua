-- Mason tool installer: LSP servers, formatters, linters
---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "eslint-lsp",
        "typescript-language-server",
        "vue-language-server",
        "pyright",
        "bash-language-server",
        -- Formatters
        "stylua",
        "prettier",
        "black",
        "shfmt",
        -- Other tools
        "tree-sitter-cli",
      },
    },
  },
}
