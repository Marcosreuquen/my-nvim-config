-- AstroUI: theme, highlights, icons
---@type LazySpec
return {
  {
    "AstroNvim/astrotheme",
    opts = {
      style = {
        transparent = true,
      },
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "astrodark",
      highlights = {
        init = {
          Comment = { italic = true },
          ["@comment"] = { italic = true },
          CopilotSuggestion = { fg = "#555555", italic = true },
          -- Full TUI transparency (floats keep solid bg for readability)
          Normal = { bg = "NONE", ctermbg = "NONE" },
          NormalNC = { bg = "NONE", ctermbg = "NONE" },
          SignColumn = { bg = "NONE", ctermbg = "NONE" },
          FoldColumn = { bg = "NONE", ctermbg = "NONE" },
          StatusLine = { bg = "NONE", ctermbg = "NONE" },
          StatusLineNC = { bg = "NONE", ctermbg = "NONE" },
          WinBar = { bg = "NONE", ctermbg = "NONE" },
          WinBarNC = { bg = "NONE", ctermbg = "NONE" },
          TabLine = { bg = "NONE", ctermbg = "NONE" },
          TabLineFill = { bg = "NONE", ctermbg = "NONE" },
          TabLineSel = { bg = "NONE", ctermbg = "NONE" },
          Pmenu = { bg = "NONE", ctermbg = "NONE" },
          PmenuSbar = { bg = "NONE", ctermbg = "NONE" },
          PmenuThumb = { bg = "NONE", ctermbg = "NONE" },
          EndOfBuffer = { bg = "NONE", ctermbg = "NONE" },
          LineNr = { bg = "NONE", ctermbg = "NONE" },
          CursorLineNr = { bg = "NONE", ctermbg = "NONE" },
          -- NeoTree sidebar transparent
          NeoTreeNormal = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeNormalNC = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeEndOfBuffer = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeSignColumn = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeWinSeparator = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeTabActive = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeTabInactive = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeTabSeparatorActive = { bg = "NONE", ctermbg = "NONE" },
          NeoTreeTabSeparatorInactive = { bg = "NONE", ctermbg = "NONE" },
        },
      },
      icons = {
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },
    },
  },
}
