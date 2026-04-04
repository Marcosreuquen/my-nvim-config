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
              if ok and opencode.statusline then return opencode.statusline() end
              return ""
            end,
          },
          surround = { separator = "right", color = status.hl.mode_bg },
          hl = status.hl.get_attributes "mode",
        },
      }
    end,
  },
}
