-- Todo-comments: TODO/FIXME highlighting & navigation
---@type LazySpec
return {
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "]T",
        function() require("todo-comments").jump_next() end,
        mode = "n",
        desc = "Next todo comment",
      },
      {
        "[T",
        function() require("todo-comments").jump_prev() end,
        mode = "n",
        desc = "Previous todo comment",
      },
      {
        "<leader>st",
        function() Snacks.picker.todo_comments() end,
        desc = "Todo",
      },
    },
    opts = {},
    config = function(_, opts) require("todo-comments").setup(opts) end,
  },
}
