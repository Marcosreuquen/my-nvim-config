return {
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-web-devicons" },
  },
}
