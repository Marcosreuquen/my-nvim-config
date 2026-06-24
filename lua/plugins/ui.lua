-- UI plugins: devicons, render-markdown, diffview, showkeys
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
  -- Git diff viewer
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "BranchDiff" },
    config = function()
      local actions = require "diffview.actions"
      require("diffview").setup {
        keymaps = {
          view = {
            { "n", "<Esc>", actions.close, { desc = "Close Diffview" } },
            { "n", "q", actions.close, { desc = "Close Diffview" } },
          },
          file_panel = {
            { "n", "<Esc>", actions.close, { desc = "Close Diffview" } },
            { "n", "q", actions.close, { desc = "Close Diffview" } },
          },
          file_history_panel = {
            { "n", "<Esc>", actions.close, { desc = "Close Diffview" } },
            { "n", "q", actions.close, { desc = "Close Diffview" } },
          },
        },
      }
      vim.api.nvim_create_user_command("BranchDiff", function(opts)
        if opts.args ~= "" then
          vim.cmd("DiffviewOpen " .. opts.args .. "...HEAD")
        else
          vim.cmd "DiffviewOpen"
        end
      end, {
        nargs = "?",
        complete = function(arglead)
          local branches = vim.fn.systemlist "git branch -a --format='%(refname:short)'"
          return vim.tbl_filter(function(b) return b:find(arglead, 1, true) == 1 end, branches)
        end,
        desc = "Diff against a branch (or uncommitted changes if no arg)",
      })
    end,
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
