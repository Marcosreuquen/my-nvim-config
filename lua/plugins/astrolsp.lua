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
    servers = {
      "lua_ls",
      "eslint",
      "ts_ls",
      "volar",
      "pyright",
      "bashls",
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
      ts_ls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
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
    -- Custom on_attach for signature help
    on_attach = function(client, bufnr)
      -- Automatic signature help on trigger characters
      if client.server_capabilities.signatureHelpProvider then
        local trigger_chars = client.server_capabilities.signatureHelpProvider.triggerCharacters or {}
        local signature_active = false

        vim.api.nvim_create_autocmd("TextChangedI", {
          group = vim.api.nvim_create_augroup("LspSignatureHelp_" .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            local cur_line = vim.api.nvim_get_current_line()
            local pos = vim.api.nvim_win_get_cursor(0)[2]
            local cur_char = cur_line:sub(pos, pos)
            local prev_char = cur_line:sub(pos - 1, pos - 1)

            local should_trigger = false
            for _, char in ipairs(trigger_chars) do
              if cur_char == char or prev_char == char then
                should_trigger = true
                break
              end
            end

            if should_trigger and not signature_active then
              signature_active = true
              vim.lsp.buf.signature_help()
              vim.defer_fn(function() signature_active = false end, 100)
            end
          end,
        })
      end
    end,
  },
}
