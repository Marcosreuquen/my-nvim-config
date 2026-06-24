local M = {}

local active_group = "bottom"

local groups = {
  bottom = {
    ids = {},
    active_id = nil,
    env = nil,
    win = {
      position = "bottom",
      height = function() return math.floor(vim.o.lines * 0.3) end,
      enter = true,
      wo = {
        winhighlight = "Normal:SnacksTerminalDocked,NormalNC:SnacksTerminalDocked,EndOfBuffer:SnacksTerminalDocked,SignColumn:SnacksTerminalDocked",
      },
    },
  },
  right = {
    ids = {},
    active_id = nil,
    env = { NVIM_SNACKS_TERM_GROUP = "right" },
    win = {
      position = "right",
      width = function() return math.floor(vim.o.columns * 0.35) end,
      enter = true,
      wo = {
        winhighlight = "Normal:SnacksTerminalDocked,NormalNC:SnacksTerminalDocked,EndOfBuffer:SnacksTerminalDocked,SignColumn:SnacksTerminalDocked",
      },
    },
  },
}

local function emit_changed()
  vim.api.nvim_exec_autocmds("User", { pattern = "TermChanged" })
end

local function get_group(name)
  return groups[name or active_group] or groups.bottom
end

local function group_name(group)
  for name, current in pairs(groups) do
    if current == group then return name end
  end
  return "bottom"
end

local function current_group_name()
  local ok, name = pcall(vim.api.nvim_buf_get_var, 0, "snacks_term_tabs_group")
  return ok and groups[name] and name or active_group
end

local function find_idx(group, id)
  for i, v in ipairs(group.ids) do
    if v == id then return i end
  end
end

local function next_free_id(group)
  local used = {}
  for _, v in ipairs(group.ids) do used[v] = true end
  local id = 1
  while used[id] do id = id + 1 end
  return id
end

local function term_opts(group, id, create)
  local name = group_name(group)
  local win_opts = vim.deepcopy(group.win)
  if type(win_opts.height) == "function" then win_opts.height = win_opts.height() end
  if type(win_opts.width) == "function" then win_opts.width = win_opts.width() end

  return {
    count = id,
    create = create,
    env = group.env,
    win = vim.tbl_deep_extend("force", win_opts, {
      on_buf = function(win)
        vim.b[win.buf].snacks_term_tabs_group = name
        vim.b[win.buf].snacks_term_tabs_id = id
      end,
      on_win = function()
        active_group = name
        vim.opt_local.scrolloff = 2
        vim.opt_local.sidescrolloff = 4
      end,
    }),
  }
end

local function get_term(group, id, create)
  return require("snacks.terminal").get(nil, term_opts(group, id, create))
end

local function prune(group)
  local kept = {}
  for _, id in ipairs(group.ids) do
    local term = get_term(group, id, false)
    if term and term:buf_valid() then
      kept[#kept + 1] = id
    end
  end
  group.ids = kept
  if group.active_id and not find_idx(group, group.active_id) then
    group.active_id = group.ids[#group.ids]
  end
end

local function hide_active(group)
  if not group.active_id then return end
  local term = get_term(group, group.active_id, false)
  if term and term:win_valid() then term:hide() end
end

local function show(group, id)
  active_group = group_name(group)
  group.active_id = id
  local term = get_term(group, id, true)
  if term then term:show() end
  emit_changed()
end

function M.toggle(name)
  local group = get_group(name or current_group_name())
  prune(group)
  if #group.ids == 0 then
    M.new(group_name(group))
    return
  end

  active_group = group_name(group)
  local term = get_term(group, group.active_id, false)
  if term then term:toggle() end
  emit_changed()
end

function M.new(name)
  local group = get_group(name or current_group_name())
  prune(group)
  hide_active(group)
  local id = next_free_id(group)
  table.insert(group.ids, id)
  show(group, id)
end

function M.close(name)
  local group = get_group(name or current_group_name())
  prune(group)
  if not group.active_id then return end

  local idx = find_idx(group, group.active_id)
  if not idx then return end

  local term = get_term(group, group.active_id, false)
  if term then term:close() end

  table.remove(group.ids, idx)

  if #group.ids > 0 then
    show(group, group.ids[math.min(idx, #group.ids)])
  else
    group.active_id = nil
    emit_changed()
  end
end

function M.next(name)
  local group = get_group(name or current_group_name())
  prune(group)
  if #group.ids <= 1 then return end
  local idx = find_idx(group, group.active_id)
  if not idx then return end
  hide_active(group)
  show(group, group.ids[(idx % #group.ids) + 1])
end

function M.prev(name)
  local group = get_group(name or current_group_name())
  prune(group)
  if #group.ids <= 1 then return end
  local idx = find_idx(group, group.active_id)
  if not idx then return end
  hide_active(group)
  show(group, group.ids[((idx - 2) % #group.ids) + 1])
end

function M.float()
  require("snacks.terminal").toggle(nil, {
    count = 1,
    env = { NVIM_SNACKS_TERM_GROUP = "float" },
    win = {
      position = "float",
      enter = true,
    },
  })
end

function M.lazygit()
  require("snacks.terminal").toggle("lazygit", {
    win = {
      position = "float",
      enter = true,
    },
  })
end

function M.lazydocker()
  require("snacks.terminal").toggle("lazydocker", {
    win = {
      position = "float",
      enter = true,
    },
  })
end

function M.resize(amount)
  local snacks_win = vim.w[vim.api.nvim_get_current_win()].snacks_win
  local is_vertical = snacks_win and (snacks_win.position == "left" or snacks_win.position == "right")
  local direction = is_vertical and "vertical resize" or "resize"
  vim.cmd(("%s %s%d"):format(direction, amount > 0 and "+" or "", amount))
end

function M.get_status()
  local group = get_group(active_group)
  prune(group)
  if #group.ids == 0 or not group.active_id then return nil end
  local idx = find_idx(group, group.active_id)
  if not idx then return nil end
  return { current = idx, total = #group.ids, group = active_group }
end

function M.setup()
  local opts = { noremap = true, silent = true }
  local term_opts = vim.tbl_extend("force", opts, { nowait = true })

  vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", vim.tbl_extend("force", opts, { desc = "Exit terminal mode" }))
  vim.keymap.set({ "n", "t" }, "<C-.>", function() M.toggle("right") end, vim.tbl_extend("force", opts, { desc = "Toggle right terminal" }))
  vim.keymap.set({ "n", "t" }, "<C-,>", function() M.toggle("bottom") end, vim.tbl_extend("force", opts, { desc = "Toggle bottom terminal" }))
  vim.keymap.set({ "n", "t" }, "<A-t>", function() M.new() end, vim.tbl_extend("force", opts, { desc = "New terminal tab" }))
  vim.keymap.set({ "n", "t" }, "<A-w>", function() M.close() end, vim.tbl_extend("force", opts, { desc = "Close terminal tab" }))
  vim.keymap.set({ "n", "t" }, "<A-.>", function() M.next() end, vim.tbl_extend("force", opts, { desc = "Next terminal tab" }))
  vim.keymap.set({ "n", "t" }, "<A-,>", function() M.prev() end, vim.tbl_extend("force", opts, { desc = "Prev terminal tab" }))

  vim.keymap.set("t", "<Esc>t", function() M.new() end, vim.tbl_extend("force", term_opts, { desc = "New terminal tab" }))
  vim.keymap.set("t", "<Esc>w", function() M.close() end, vim.tbl_extend("force", term_opts, { desc = "Close terminal tab" }))
  vim.keymap.set("t", "<Esc>.", function() M.next() end, vim.tbl_extend("force", term_opts, { desc = "Next terminal tab" }))
  vim.keymap.set("t", "<Esc>,", function() M.prev() end, vim.tbl_extend("force", term_opts, { desc = "Prev terminal tab" }))

  vim.keymap.set({ "n", "t" }, "<C-=>", function() M.resize(1) end, vim.tbl_extend("force", opts, { desc = "Increase terminal size" }))
  vim.keymap.set({ "n", "t" }, "<C-->", function() M.resize(-1) end, vim.tbl_extend("force", opts, { desc = "Decrease terminal size" }))

  vim.keymap.set({ "n", "t" }, "<Leader>tf", M.float, vim.tbl_extend("force", opts, { desc = "Float terminal" }))
  vim.keymap.set({ "n", "t" }, "<Leader>tl", M.lazygit, vim.tbl_extend("force", opts, { desc = "Lazygit" }))
  vim.keymap.set({ "n", "t" }, "<Leader>td", M.lazydocker, vim.tbl_extend("force", opts, { desc = "Lazydocker" }))

  vim.api.nvim_create_user_command("Lazydocker", M.lazydocker, { desc = "Open Lazydocker" })
end

return M
