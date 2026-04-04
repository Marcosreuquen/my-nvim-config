-- Completion: customize blink.cmp (AstroNvim's default engine)
-- and disable nvim-cmp which was leftover from NvChad migration
---@type LazySpec
return {
  -- Disable nvim-cmp and all its sources (blink.cmp is the completion engine)
  { "hrsh7th/nvim-cmp", enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "hrsh7th/cmp-buffer", enabled = false },
  { "hrsh7th/cmp-path", enabled = false },
  { "hrsh7th/cmp-nvim-lsp-signature-help", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },

  -- Customize blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
      },
      signature = { enabled = true },
      keymap = {
        -- CR only accepts if an item is explicitly selected, otherwise newline
        ["<CR>"] = { "accept", "fallback" },
        -- S-Tab: prev item in menu, or accept Copilot if visible, or fallback
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          function()
            local ok, suggestion = pcall(require, "copilot.suggestion")
            if ok and suggestion.is_visible() then
              suggestion.accept()
              return true -- handled
            end
          end,
          "fallback",
        },
      },
    },
  },
}
