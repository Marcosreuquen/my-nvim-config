-- AstroCore: core features, vim options, mappings, autocommands
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        -- Treesitter-based folding
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        foldenable = true,
        foldlevel = 99,
        foldlevelstart = 99,
        -- Rounded borders on all floating windows
        winborder = "rounded",
      },
      g = {},
    },
    mappings = {
      n = {
        -- Enter command mode with ;
        [";"] = { ":", desc = "CMD enter command mode" },

        -- Undo
        ["<C-z>"] = { "<cmd>undo<CR>", desc = "Undo last change" },

        -- LSP mappings
        ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", desc = "Go to definition" },
        ["gr"] = { "<cmd>Telescope lsp_references<CR>", desc = "Show references" },
        ["gi"] = { "<cmd>Telescope lsp_implementations<CR>", desc = "Show implementations" },
        ["K"] = { function() vim.lsp.buf.hover() end, desc = "Show hover information" },
        ["<Leader>ca"] = { function() vim.lsp.buf.code_action() end, desc = "Show code actions" },

        -- Buffer navigation (AstroNvim style)
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Close buffer from tabline
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Close buffer from tabline",
        },
      },
      i = {
        -- Exit insert mode with jk
        ["jk"] = { "<ESC>", desc = "Exit insert mode" },
        -- Undo in insert mode
        ["<C-z>"] = { "<C-o>u", desc = "Undo last change" },
      },
    },
  },
}
