-- ToggleTerm: terminal manager with tab system
---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("toggleterm").setup {
        direction = "horizontal",
        size = function(term) return math.floor(vim.o.lines * 0.3) end,
        highlights = {
          Normal = { guibg = "NONE" },
          NormalNC = { guibg = "NONE" },
          NormalFloat = { guibg = "NONE" },
        },
        on_open = function(term)
          vim.opt_local.scrolloff = 2
          vim.opt_local.sidescrolloff = 4
        end,
      }

      require("custom.term_tabs").setup()

      vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true, silent = true })

      vim.keymap.set({ "n", "t" }, "<C-=>", function() vim.cmd "resize +1" end, { noremap = true, silent = true })

      vim.keymap.set({ "n", "t" }, "<C-->", function() vim.cmd "resize -1" end, { noremap = true, silent = true })
    end,
  },
}
