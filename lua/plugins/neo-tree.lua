-- Neo-tree: file explorer (AstroNvim default)
---@type LazySpec
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      filesystem = {
        -- Open as sidebar instead of taking over the full window on startup
        hijack_netrw_behavior = 'open_default',
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        window = {
          mappings = {
            ['<Delete>'] = 'noop',
            -- Map Backspace to toggle the node (collapse/expand) instead of
            -- changing the filesystem root. This keeps the explorer scoped to
            -- the project root while allowing quick collapse/expand.
            ['<Backspace>'] = 'toggle_node',
          },
        },
      },
    },
    window = {
      width = 35,
    },
  },
}
