-- Neo-tree: file explorer (AstroNvim default)
---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- Open as sidebar instead of taking over the full window on startup
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        window = {
          mappings = {
            ["<Delete>"] = "noop",
          },
        },
      },
      window = {
        width = 35,
      },
    },
  },
}
