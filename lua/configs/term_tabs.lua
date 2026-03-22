local M = {}

local term_ids = {}   -- lista ordenada de IDs de terminales activas
local active_id = nil -- ID de la terminal actualmente visible

local function find_idx(id)
  for i, v in ipairs(term_ids) do
    if v == id then return i end
  end
end

local function next_free_id()
  local used = {}
  for _, v in ipairs(term_ids) do used[v] = true end
  local id = 1
  while used[id] do id = id + 1 end
  return id
end

local function get_term(id)
  return require("toggleterm.terminal").get(id)
end

local function update_indicator()
  -- Terminal indicator now lives in the statusline via statusline.lua
end

local function hide_active()
  if active_id then
    local term = get_term(active_id)
    if term and term.window and vim.api.nvim_win_is_valid(term.window) then
      term:close()
    end
  end
end

-- Alterna la terminal activa (o crea la primera si no hay ninguna)
function M.toggle()
  if #term_ids == 0 then
    M.new()
  else
    local term = get_term(active_id)
    if term then
      term:toggle()
      update_indicator()
    end
  end
end

-- Crea una nueva terminal y la muestra
function M.new()
  hide_active()
  local id = next_free_id()
  table.insert(term_ids, id)
  active_id = id
  vim.cmd(id .. "ToggleTerm")
  update_indicator()
end

-- Cierra y elimina la terminal activa, luego va a la adyacente
function M.close()
  if not active_id then return end
  local idx = find_idx(active_id)
  if not idx then return end

  local term = get_term(active_id)
  if term then
    if term.window and vim.api.nvim_win_is_valid(term.window) then
      term:close()
    end
    if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
      vim.api.nvim_buf_delete(term.bufnr, { force = true })
    end
  end

  table.remove(term_ids, idx)

  if #term_ids > 0 then
    active_id = term_ids[math.min(idx, #term_ids)]
    vim.cmd(active_id .. "ToggleTerm")
    update_indicator()
  else
    active_id = nil
  end
end

-- Salta a la siguiente terminal (cíclico)
function M.next()
  if #term_ids <= 1 then return end
  local idx = find_idx(active_id)
  if not idx then return end
  hide_active()
  active_id = term_ids[(idx % #term_ids) + 1]
  vim.cmd(active_id .. "ToggleTerm")
  update_indicator()
end

-- Salta a la terminal anterior (cíclico)
function M.prev()
  if #term_ids <= 1 then return end
  local idx = find_idx(active_id)
  if not idx then return end
  hide_active()
  active_id = term_ids[((idx - 2) % #term_ids) + 1]
  vim.cmd(active_id .. "ToggleTerm")
  update_indicator()
end

-- Expose terminal state for statusline
function M.get_status()
  if #term_ids == 0 or not active_id then return nil end
  local idx = find_idx(active_id)
  if not idx then return nil end
  return { current = idx, total = #term_ids }
end

function M.setup()
  local opts = { noremap = true, silent = true }

  -- Reemplaza el toggle principal para usar el sistema de tabs
  vim.keymap.set({ "n", "t" }, "<C-t>", M.toggle, vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))

  -- Nueva terminal (tab)
  vim.keymap.set({ "n", "t" }, "<A-t>", M.new, vim.tbl_extend("force", opts, { desc = "New terminal tab" }))

  -- Cerrar terminal actual
  vim.keymap.set({ "n", "t" }, "<A-w>", M.close, vim.tbl_extend("force", opts, { desc = "Close terminal tab" }))

  -- Navegar entre terminales
  vim.keymap.set({ "n", "t" }, "<A-l>", M.next, vim.tbl_extend("force", opts, { desc = "Next terminal tab" }))
  vim.keymap.set({ "n", "t" }, "<A-h>", M.prev, vim.tbl_extend("force", opts, { desc = "Prev terminal tab" }))
end

return M
