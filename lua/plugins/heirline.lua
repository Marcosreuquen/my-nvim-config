-- Heirline: extend default AstroNvim statusline with OpenCode status
---@type LazySpec
return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
        -- OpenCode statusline component
        status.component.builder {
          {
            provider = function()
              local ok, opencode = pcall(require, "opencode")
              if not ok then return "" end
              local base = opencode.statusline()
              if not base or base == "" then return "" end
              return " 󱚧 OpenCode "
            end,
          },
          surround = { separator = "right", color = status.hl.mode_bg},
          -- hl = status.hl.get_attributes "mode",
          hl = { fg = '#555555', bg = status.hl.mode_bg }
        },
        -- Terminal tabs status
        status.component.builder {
          {
            provider = function()
              local ok, term_tabs = pcall(require, "custom.term_tabs")
              if not ok then return "" end
              local s = term_tabs.get_status()
              if not s then return "" end
              return " " .. " " .. s.current .. "/" .. s.total .. " "
            end,
          },
          update = { "User", pattern = "TermChanged" },
          hl = status.hl.get_attributes "area_nav",
        },
      }
    end,
  },
}
