-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
  transparency = true,
	hl_override = {
	  Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

local stl = require "configs.statusline"

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "round",

    order = {
      "mode", "project_name", "file", "git_status",
      "%=", "lsp_msg", "%=",
      "term_info", "lang_versions", "diagnostics", "lsp", "cursor",
    },

    modules = {
      project_name  = stl.project_name,
      git_status    = stl.git_status,
      lang_versions = stl.language_versions,
      term_info     = stl.term_info,
    },
  },
}

return M
