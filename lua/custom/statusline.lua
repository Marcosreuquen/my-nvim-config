local M = {}

-- ── Cache ──────────────────────────────────────────────────────────
local lang_cache = { cwd = "", langs = {} }

local markers = {
  { file = "package.json",     cmd = "node -v",            icon = " ", name = "Node" },
  { file = "requirements.txt", cmd = "python3 -V",         icon = " ", name = "Py",   parse = "Python (.+)" },
  { file = "pyproject.toml",   cmd = "python3 -V",         icon = " ", name = "Py",   parse = "Python (.+)" },
  { file = "Pipfile",          cmd = "python3 -V",         icon = " ", name = "Py",   parse = "Python (.+)" },
  { file = "go.mod",           cmd = "go version",         icon = " ", name = "Go",   parse = "go(%S+)" },
  { file = "Cargo.toml",       cmd = "rustc --version",    icon = " ", name = "Rs",   parse = "rustc (%S+)" },
  { file = "Gemfile",          cmd = "ruby -v",            icon = " ", name = "Rb",   parse = "ruby (%S+)" },
  { file = "mix.exs",          cmd = "elixir -v",          icon = " ", name = "Ex",   parse = "Elixir (%S+)" },
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
          table.insert(results, { icon = m.icon, name = m.name, ver = ver })
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

-- ── Helper: get statusline bg ─────────────────────────────────────

local function get_stl_bg()
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "StatusLine", link = false })
  if ok and hl and hl.bg then
    return string.format("#%06x", hl.bg)
  end
  return "NONE"
end

-- ── Statusline Modules ────────────────────────────────────────────

function M.language_versions()
  local langs = detect_langs()
  if #langs == 0 then return "" end
  local parts = {}
  for _, l in ipairs(langs) do
    table.insert(parts, l.icon .. l.ver)
  end
  return "%#StLangVersions#  " .. table.concat(parts, "  ") .. " "
end

function M.project_name()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return "%#StProjectName# 󰉋 " .. cwd .. " "
end

function M.git_status()
  local status = vim.b.gitsigns_status_dict
  if not status or not status.head or status.head == "" then
    local branch = vim.fn.system("git -C " .. vim.fn.getcwd() .. " branch --show-current 2>/dev/null"):gsub("%s+$", "")
    if vim.v.shell_error ~= 0 or branch == "" then
      return ""
    end
    return "%#StGitBranch#  " .. branch .. " "
  end

  local parts = { "%#StGitBranch#  " .. status.head }

  local added = status.added or 0
  local changed = status.changed or 0
  local removed = status.removed or 0

  if added > 0 then
    table.insert(parts, "%#StGitAdd# +" .. added)
  end
  if changed > 0 then
    table.insert(parts, "%#StGitChange# ~" .. changed)
  end
  if removed > 0 then
    table.insert(parts, "%#StGitRemove# -" .. removed)
  end

  return table.concat(parts, "") .. " "
end

function M.term_info()
  local ok, tabs = pcall(function()
    return require("custom.term_tabs").get_status()
  end)
  if not ok or not tabs then return "" end
  return "%#StTermInfo# >_ " .. tabs.current .. "/" .. tabs.total .. " "
end

-- ── Highlight Groups ──────────────────────────────────────────────

function M.setup_highlights()
  local set = vim.api.nvim_set_hl
  local bg = get_stl_bg()

  set(0, "StProjectName", { fg = "#e5c07b", bg = bg, bold = true })
  set(0, "StGitBranch",   { fg = "#c678dd", bg = bg, bold = true })
  set(0, "StGitAdd",      { fg = "#98c379", bg = bg })
  set(0, "StGitChange",   { fg = "#e5c07b", bg = bg })
  set(0, "StGitRemove",   { fg = "#e06c75", bg = bg })
  set(0, "StLangVersions",{ fg = "#56b6c2", bg = bg })
  set(0, "StTermInfo",    { fg = "#61afef", bg = bg, bold = true })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    vim.defer_fn(M.setup_highlights, 50)
  end,
})

M.setup_highlights()

return M
