-- UI plugins: devicons, render-markdown, codediff, showkeys, github_dark theme
---@type LazySpec
return {
  -- GitHub Dark theme
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
  },
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
