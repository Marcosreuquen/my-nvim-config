local M = {}

local function format_time(timestamp)
  local diff = os.time() - math.floor(timestamp / 1000)
  if diff < 3600 then
    local mins = math.floor(diff / 60)
    return mins .. "m ago"
  elseif diff < 86400 then
    local hours = math.floor(diff / 3600)
    return hours .. "h ago"
  else
    local days = math.floor(diff / 86400)
    return days .. "d ago"
  end
end

function M.pick_session()
  local cmd = "opencode session list --format json --max-count 50"
  local handle = io.popen(cmd .. " 2>/dev/null")
  if not handle then
    vim.notify("Failed to list opencode sessions", vim.log.levels.ERROR)
    return
  end

  local result = handle:read("*a")
  handle:close()

  local ok, sessions = pcall(vim.json.decode, result)
  if not ok or not sessions or #sessions == 0 then
    vim.notify("No opencode sessions found", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, session in ipairs(sessions) do
    local time_ago = format_time(session.updated)
    local dir = session.directory or ""
    local short_dir = vim.fn.fnamemodify(dir, ":t")
    table.insert(items, {
      title = session.title or "Untitled",
      sub = short_dir .. "  •  " .. time_ago,
      session_id = session.id,
      directory = dir,
    })
  end

  Snacks.picker.select(items, {
    prompt = "Select session to resume...",
    format_item = function(item)
      return item.title .. "  " .. item.sub
    end,
  }, function(item)
    if item then
      vim.g.opencode_last_session = item.session_id
      vim.g.opencode_last_session_title = item.title

      local terminal = require("snacks.terminal")
      local cmd = "opencode --port 54403 -s " .. item.session_id
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = false,
          on_win = function(win)
            require("opencode.terminal").setup(win.win)
          end,
        },
      }

      terminal.toggle(cmd, snacks_terminal_opts)
    end
  end)
end

return M
