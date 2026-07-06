-- UI plugins: devicons, render-markdown, codediff, showkeys
---@type LazySpec
return {
  -- Render markdown in-editor
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- CodeDiff viewer
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },
  -- Show keystrokes on screen
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 3,
      position = "top-right",
      show_count = true,
    },
  },
}
