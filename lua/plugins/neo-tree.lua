-- Neo-tree: file explorer (AstroNvim default)
---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Override window width after AstroNvim sets its defaults
      opts.window = opts.window or {}
      opts.window.width = 35
      opts.window.auto_expand_width = false

      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      }
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = vim.tbl_deep_extend("force", opts.filesystem.window.mappings or {}, {
        ["<Delete>"] = "noop",
      })

      return opts
    end,
  },
}
