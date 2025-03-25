return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
      })

      vim.keymap.set("n", "<C-t>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true})
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,   -- Show hidden files
          git_ignored = false -- Show files ignored by Git
        },
        git = {
          enable = true,
          ignore = false,  -- Dont hide ignored files
        },
        view = {
          width = 35,
          side = "left",
          adaptive_size = false,
        },
        renderer = {
          highlight_git = true,
          root_folder_label = false,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
      })
    end
  },
  {
    "github/copilot.vim",
    lazy = false,
  }
}
