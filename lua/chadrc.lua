-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "github_dark",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  statusline = {
    enabled = false,
  },
}

-- local stl = require "custom.statusline"
--
-- M.ui = {
--   statusline = {
--     theme = "default",
--     sep_style = "block",
--
--     order = {
--       "mode", "file", 'git',
--       "%=", "lsp_msg", "%=",
--       "copilot_hint", "term_info", "lang_versions", "diagnostics", "lsp", "cursor",
--     },
--
--     modules = {
--       lang_versions = stl.language_versions,
--       term_info     = stl.term_info,
--       copilot_hint  = stl.copilot_hint,
--     },
--   },
-- }

return M
