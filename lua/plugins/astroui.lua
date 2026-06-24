-- AstroUI: theme, highlights, icons
local transparency_enabled = false

local transparent_highlights = {
  -- Full TUI transparency (floats keep solid bg for readability)
  Normal = { bg = 'NONE', ctermbg = 'NONE' },
  NormalNC = { bg = 'NONE', ctermbg = 'NONE' },
  SignColumn = { bg = 'NONE', ctermbg = 'NONE' },
  FoldColumn = { bg = 'NONE', ctermbg = 'NONE' },
  StatusLine = { bg = 'NONE', ctermbg = 'NONE' },
  StatusLineNC = { bg = 'NONE', ctermbg = 'NONE' },
  WinBar = { bg = 'NONE', ctermbg = 'NONE' },
  WinBarNC = { bg = 'NONE', ctermbg = 'NONE' },
  TabLine = { bg = 'NONE', ctermbg = 'NONE' },
  TabLineFill = { bg = 'NONE', ctermbg = 'NONE' },
  TabLineSel = { bg = 'NONE', ctermbg = 'NONE' },
  Pmenu = { bg = 'NONE', ctermbg = 'NONE' },
  PmenuSbar = { bg = 'NONE', ctermbg = 'NONE' },
  PmenuThumb = { bg = 'NONE', ctermbg = 'NONE' },
  EndOfBuffer = { bg = 'NONE', ctermbg = 'NONE' },
  LineNr = { bg = 'NONE', ctermbg = 'NONE' },
  CursorLineNr = { bg = 'NONE', ctermbg = 'NONE' },
  -- NeoTree sidebar transparent
  NeoTreeNormal = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeNormalNC = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeEndOfBuffer = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeSignColumn = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeWinSeparator = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeTabActive = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeTabInactive = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeTabSeparatorActive = { bg = 'NONE', ctermbg = 'NONE' },
  NeoTreeTabSeparatorInactive = { bg = 'NONE', ctermbg = 'NONE' },
  SnacksTerminalDocked = { bg = 'NONE', ctermbg = 'NONE' },
}

local function base_highlights()
  return {
    Comment = { italic = true },
    ['@comment'] = { italic = true },
    CopilotSuggestion = { fg = '#555555', italic = true },
    MiniIconsAzure = { link = 'Function' },
    MiniIconsBlue = { link = 'DiagnosticInfo' },
    MiniIconsCyan = { link = 'DiagnosticHint' },
    MiniIconsGreen = { link = 'DiagnosticOk' },
    MiniIconsGrey = {},
    MiniIconsOrange = { link = 'DiagnosticWarn' },
    MiniIconsPurple = { link = 'Constant' },
    MiniIconsRed = { link = 'DiagnosticError' },
    MiniIconsYellow = { link = 'DiagnosticWarn' },
  }
end

local function highlights()
  if transparency_enabled then
    return vim.tbl_extend('force', base_highlights(), transparent_highlights)
  end
  return base_highlights()
end

local function reload_colorscheme()
  local colorscheme = vim.g.colors_name
  if colorscheme then
    pcall(vim.cmd.colorscheme, colorscheme)
  end
end

local function set_transparency(enabled)
  transparency_enabled = enabled

  local ok, astrotheme = pcall(require, 'astrotheme')
  if ok and astrotheme.config and astrotheme.config.style then
    astrotheme.config.style.transparent = enabled
  end

  reload_colorscheme()
  vim.notify(('Transparency %s'):format(enabled and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_transparency()
  set_transparency(not transparency_enabled)
end

---@type LazySpec
return {
  {
    'AstroNvim/astrotheme',
    opts = {
      style = {
        transparent = true,
      },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
    },
  },
  {
    'AstroNvim/astroui',
    init = function()
  vim.api.nvim_create_user_command('ToggleTransparency', toggle_transparency, {
    desc = 'Toggle transparent UI backgrounds',
  })
    end,
    ---@type AstroUIOpts
    opts = {
      colorscheme = 'onedark',
      highlights = {
        init = highlights,
      },
      icons = {
        LSPLoading1 = '⠋',
        LSPLoading2 = '⠙',
        LSPLoading3 = '⠹',
        LSPLoading4 = '⠸',
        LSPLoading5 = '⠼',
        LSPLoading6 = '⠴',
        LSPLoading7 = '⠦',
        LSPLoading8 = '⠧',
        LSPLoading9 = '⠇',
        LSPLoading10 = '⠏',
      },
    },
  },
}
