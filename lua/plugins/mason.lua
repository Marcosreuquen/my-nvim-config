-- Mason tool installer: extra tools not covered by AstroCommunity packs
-- Community packs already install: lua-language-server, stylua, selene, vtsls,
-- vue-language-server, basedpyright, black, isort, bash-language-server,
-- shellcheck, shfmt, debugpy, js-debug-adapter, bash-debug-adapter
---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettier",
        "tree-sitter-cli",
      },
    },
  },
}
