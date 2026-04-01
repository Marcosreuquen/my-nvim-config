return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This is needed to show filtered items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/folders
        }
      }
    }
  },
}

