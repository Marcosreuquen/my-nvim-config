-- Persistence: session save/restore with OpenCode integration
---@type LazySpec
return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
      pre_save = function()
        local cmd = "opencode session list --format json --max-count 1"
        local handle = io.popen(cmd .. " 2>/dev/null")
        if handle then
          local result = handle:read "*a"
          handle:close()
          local ok, sessions = pcall(vim.json.decode, result)
          if ok and sessions and #sessions > 0 then
            local session = sessions[1]
            vim.g.opencode_last_session = session.id
            vim.g.opencode_last_session_title = session.title
          end
        end
      end,
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoad",
        callback = function()
          local opencode_session = vim.g.opencode_last_session
          if opencode_session then
            vim.notify(
              "Last opencode session: " .. (vim.g.opencode_last_session_title or opencode_session),
              vim.log.levels.INFO
            )
          end
        end,
      })
    end,
  },
}
