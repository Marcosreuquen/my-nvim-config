-- Terminal keymaps backed by snacks.nvim
---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    init = function()
      require("custom.term_tabs").setup()
    end,
  },
}
