-- Heirline: AI tools statusline components (Claude, Copilot, OpenCode)
---@type LazySpec
return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      -- LSP-style spinner (matches astroui LSPLoading icons)
      local spin_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      local spin_frame = 1
      local spin_timer = nil

      local function spin_start()
        if spin_timer then return end
        spin_timer = vim.loop.new_timer()
        spin_timer:start(0, 100, vim.schedule_wrap(function()
          spin_frame = (spin_frame % #spin_frames) + 1
          vim.cmd "redrawstatus"
        end))
      end

      local function spin_stop()
        if not spin_timer then return end
        spin_timer:stop()
        spin_timer:close()
        spin_timer = nil
        spin_frame = 1
        vim.cmd "redrawstatus"
      end

      -- Copilot: reactive handler starts/stops the animation
      local ok_cop_mod, cop_mod = pcall(require, "copilot.status")
      if ok_cop_mod then
        cop_mod.register_status_notification_handler(vim.schedule_wrap(function(data)
          if data.status == "InProgress" then
            spin_start()
          else
            spin_stop()
          end
        end))
      end

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

        -- Claude component: visible when claudecode server is running
        status.component.builder {
          condition = function()
            local ok, cc = pcall(require, "claudecode")
            return ok and cc.state ~= nil and cc.state.server ~= nil
          end,
          {
            provider = " ✦ Claude ",
            hl = function()
              local ok, claudecode = pcall(require, "claudecode")
              local connected = ok and claudecode.is_claude_connected()
              return { fg = connected and "#e8875a" or "#666666", bg = "NONE" }
            end,
          },
          update = { "BufEnter", "WinEnter", "FocusGained", "User" },
        },

        -- Copilot component: visible when LSP is active
        status.component.builder {
          condition = function()
            local ok, cop = pcall(require, "copilot.status")
            return ok and cop.data.status ~= ""
          end,
          {
            provider = function()
              local ok, cop = pcall(require, "copilot.status")
              if not ok then return "" end
              if cop.data.status == "InProgress" then
                return "  Copilot " .. spin_frames[spin_frame] .. " "
              end
              return "  Copilot "
            end,
            hl = function()
              local ok, cop = pcall(require, "copilot.status")
              local active = ok and (cop.data.status == "Normal" or cop.data.status == "InProgress")
              return { fg = active and "#a8cc8c" or "#666666", bg = "NONE" }
            end,
          },
          update = { "BufEnter", "WinEnter", "FocusGained", "User" },
        },

        -- OpenCode component: visible when a session is running
        status.component.builder {
          condition = function()
            local ok, opencode = pcall(require, "opencode")
            if not ok then return false end
            local base = opencode.statusline()
            return base ~= nil and base ~= ""
          end,
          {
            provider = function()
              local ok, opencode = pcall(require, "opencode")
              if not ok then return "" end
              local s = opencode.statusline()
              if s and s:find("running") then
                return " 󱚧 OpenCode " .. spin_frames[spin_frame] .. " "
              end
              return " 󱚧 OpenCode "
            end,
            hl = function() return { fg = "#6699cc", bg = "NONE" } end,
          },
          update = { "BufEnter", "WinEnter", "FocusGained", "User" },
        },

        -- Markdown Preview component: visible when a live-server is active
        status.component.builder {
          condition = function()
            local ok, mp = pcall(require, "markdown_preview")
            return ok and (mp._server_instance ~= nil or mp._takeover_port ~= nil)
          end,
          {
            provider = function()
              local ok, mp = pcall(require, "markdown_preview")
              if not ok then return "" end
              local port = mp._server_instance and mp._server_instance.port or mp._takeover_port
              return " 󰍔 MD :" .. tostring(port) .. " "
            end,
            hl = function() return { fg = "#e5c07b", bg = "NONE" } end,
          },
          update = { "BufEnter", "WinEnter", "FocusGained", "User" },
        },

        -- Terminal tabs status
        status.component.builder {
          {
            provider = function()
              local ok, term_tabs = pcall(require, "custom.term_tabs")
              if not ok then return "" end
              local s = term_tabs.get_status()
              if not s then return "" end
              return " " .. " " .. s.current .. "/" .. s.total .. " "
            end,
          },
          update = { "User", pattern = "TermChanged" },
          hl = status.hl.get_attributes "area_nav",
        },
      }
    end,
  },
}
