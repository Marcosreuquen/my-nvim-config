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
      -- LSP Signature Help with snacks.nvim style popup
      local signature_group = vim.api.nvim_create_augroup("LspSignatureHelp", { clear = true })
      local signature_active = false

      vim.api.nvim_create_autocmd("LspAttach", {
        group = signature_group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.server_capabilities.signatureHelpProvider then
            return
          end

          local trigger_chars = client.server_capabilities.signatureHelpProvider.triggerCharacters or {}
          local bufnr = args.buf

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
                vim.defer_fn(function()
                  signature_active = false
                end, 100)
              end
            end,
          })
        end,
      })

      -- Configure signature help popup style
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        max_height = 12,
        max_width = 80,
        focusable = false,
        silent = true,
      })
    end,
  },
}
