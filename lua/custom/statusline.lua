local M = {}

-- ── Cache ──────────────────────────────────────────────────────────
local lang_cache = { cwd = "", langs = {} }

local markers = {
  { file = "package.json",     cmd = "node -v",         codepoint = 0xE718, name = "Node" },
  { file = "requirements.txt", cmd = "python3 -V",      codepoint = 0xE73C, name = "Py",  parse = "Python (.+)" },
  { file = "pyproject.toml",   cmd = "python3 -V",      codepoint = 0xE73C, name = "Py",  parse = "Python (.+)" },
  { file = "Pipfile",          cmd = "python3 -V",      codepoint = 0xE73C, name = "Py",  parse = "Python (.+)" },
  { file = "go.mod",           cmd = "go version",      codepoint = 0xE626, name = "Go",  parse = "go(%S+)" },
  { file = "Cargo.toml",       cmd = "rustc --version", codepoint = 0xE7A8, name = "Rs",  parse = "rustc (%S+)" },
  { file = "Gemfile",          cmd = "ruby -v",         codepoint = 0xE739, name = "Rb",  parse = "ruby (%S+)" },
  { file = "mix.exs",          cmd = "elixir -v",       codepoint = 0xE62D, name = "Ex",  parse = "Elixir (%S+)" },
}

local function detect_langs()
  local cwd = vim.fn.getcwd()
  if lang_cache.cwd == cwd and #lang_cache.langs > 0 then
    return lang_cache.langs
  end

  local results = {}
  local seen = {}

  for _, m in ipairs(markers) do
    if not seen[m.cmd] and vim.fn.filereadable(cwd .. "/" .. m.file) == 1 then
      seen[m.cmd] = true
      local raw = vim.fn.system(m.cmd .. " 2>/dev/null"):gsub("%s+$", "")
      if vim.v.shell_error == 0 and raw ~= "" then
        local ver = m.parse and raw:match(m.parse) or raw
        if ver then
          table.insert(results, {
            icon = vim.fn.nr2char(m.codepoint),
            name = m.name,
            ver = ver,
          })
        end
      end
    end
  end

  lang_cache = { cwd = cwd, langs = results }
  return results
end

vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  callback = function() lang_cache = { cwd = "", langs = {} } end,
})

-- ── Helpers ───────────────────────────────────────────────────────

local function hl_attr(group, attr)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if ok and hl and hl[attr] then
    return string.format("#%06x", hl[attr])
  end
  return nil
end

-- Generate special chars at runtime to avoid encoding issues in source file
-- 0xE0B2 / 0xE0B0 = classic powerline diagonal triangles (NvChad "default")
local sep_l = "" --vim.fn.nr2char(0xE0B2) -- left-pointing diagonal
local sep_r = "" --vim.fn.nr2char(0xE0B0) -- right-pointing diagonal

-- ── Statusline Modules ────────────────────────────────────────────

function M.project_name()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return "%#StProjectName# " .. icon_folder .. " " .. cwd .. " %#StProjectSep#" .. sep_r
end

function M.language_versions()
  local langs = detect_langs()
  if #langs == 0 then return "" end
  local parts = {}
  for _, l in ipairs(langs) do
    table.insert(parts, l.icon .. " " .. l.ver)
  end
  return "%#StLangSep#" .. sep_l .. "%#StLangVersions# " .. table.concat(parts, "  ") .. " %#StLangSepR#" .. sep_r
end

function M.term_info()
  local ok, tabs = pcall(function()
    return require("custom.term_tabs").get_status()
  end)
  if not ok or not tabs then return "" end
  return "%#StTermSep#" .. sep_l .. "%#StTermInfo# >_ " .. tabs.current .. "/" .. tabs.total .. " %#StTermSepR#" .. sep_r
end

function M.copilot_hint()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    return "%#StCopilotSep#" .. sep_l .. "%#StCopilotHint#  ⌥L accept %#StCopilotSepR#" .. sep_r
  end
  return ""
end

-- ── Highlight Groups ──────────────────────────────────────────────

function M.setup_highlights()
  local set        = vim.api.nvim_set_hl

  -- Pull the real bg from NvChad's St_file section (always has a bg even
  -- with transparency) and fall back to a sensible tokyonight dark tone.
  local stl_bg     = hl_attr("StatusLine", "bg") or "NONE"
  local section_bg = hl_attr("St_file", "bg") or "#292e42"

  -- Project name — warm muted gold, closes right with diagonal sep
  set(0, "StProjectName", { fg = "#e0af68", bg = section_bg, bold = true })
  set(0, "StProjectSep", { fg = section_bg, bg = stl_bg })

  -- Language versions — soft cyan
  set(0, "StLangVersions", { fg = "#7dcfff", bg = section_bg })
  set(0, "StLangSep", { fg = section_bg, bg = stl_bg })
  set(0, "StLangSepR", { fg = section_bg, bg = stl_bg })

  -- Terminal info — soft blue
  set(0, "StTermInfo", { fg = "#7aa2f7", bg = section_bg, bold = true })
  set(0, "StTermSep", { fg = section_bg, bg = stl_bg })
  set(0, "StTermSepR", { fg = section_bg, bg = stl_bg })

  -- Copilot hint — green accent
  set(0, "StCopilotHint", { fg = "#9ece6a", bg = section_bg, bold = true })
  set(0, "StCopilotSep", { fg = section_bg, bg = stl_bg })
  set(0, "StCopilotSepR", { fg = section_bg, bg = stl_bg })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    vim.defer_fn(M.setup_highlights, 50)
  end,
})

M.setup_highlights()

return M
