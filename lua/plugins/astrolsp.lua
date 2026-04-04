-- AstroLSP: LSP configuration, formatting, and LSP-specific mappings
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = false, -- We use conform.nvim for format-on-save (git-hunk-aware)
      },
      disabled = {
        "lua_ls", -- Use stylua via conform instead
      },
      timeout_ms = 2000,
    },
    -- Servers to enable (installed via mason-tool-installer or manually)
    -- NOTE: vtsls, basedpyright, lua_ls, bashls, volar are added by AstroCommunity packs.
    -- Only list servers NOT covered by community packs here.
    servers = {
      "eslint",
    },
    -- Per-server configuration
    config = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    },
    -- LSP-specific mappings (only active when LSP is attached)
    mappings = {
      n = {
        ["gD"] = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
      },
    },
    -- Signature help is handled by cmp-nvim-lsp-signature-help source in cmp.lua
  },
}
