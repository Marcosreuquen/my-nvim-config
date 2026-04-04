-- Lualine: statusline (replaces AstroNvim's default heirline)
---@type LazySpec
return {
  -- Disable AstroNvim's default heirline statusline
  { "rebelot/heirline.nvim", optional = true, opts = function(_, opts) opts.statusline = nil end },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lsp = {
        "lsp_status",
        color = { gui = "bold" },
        icon = " ",
        separator = { left = "", right = "" },
      }

      require("lualine").setup {
        options = {
          theme = "nightfly",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_z = {
            lsp,
            { require("opencode").statusline, separator = { left = "", right = "" } },
          },
        },
      }
    end,
  },
}
