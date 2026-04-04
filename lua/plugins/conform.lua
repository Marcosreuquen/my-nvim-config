-- conform.nvim: formatters with git-hunk-aware format-on-save
---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      format_on_save = function(bufnr)
        local file = vim.fn.expand "%:p"
        -- Only use range formatting for git-tracked files
        local in_git = vim.fn
          .system("git -C " .. vim.fn.shellescape(vim.fn.expand "%:h") .. " rev-parse --is-inside-work-tree 2>/dev/null")
          :find "true"
        if not in_git then return { timeout_ms = 2000, lsp_fallback = true } end

        local hunks = {}
        local diff = vim.fn.systemlist("git diff --unified=0 HEAD -- " .. vim.fn.shellescape(file))
        for _, line in ipairs(diff) do
          local start_line, count = line:match "^@@ %-%d+,?%d* %+(%d+),?(%d*) @@"
          if start_line then
            start_line = tonumber(start_line)
            count = tonumber(count) or 1
            if count > 0 then
              table.insert(hunks, {
                start = { start_line, 0 },
                ["end"] = { start_line + count - 1, 0 },
              })
            end
          end
        end

        if #hunks == 0 then return end

        local conform = require "conform"
        for _, hunk in ipairs(hunks) do
          conform.format {
            bufnr = bufnr,
            timeout_ms = 2000,
            lsp_fallback = true,
            range = hunk,
          }
        end
        -- Return nil to skip default format (we already formatted)
      end,
    },
  },
}
