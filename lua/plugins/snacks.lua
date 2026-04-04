-- Snacks.nvim: UI framework (notifications, input, picker, terminal)
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = {
        enabled = true,
      },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<a-a>"] = {
                "opencode_send",
                mode = { "n", "i" },
              },
            },
          },
        },
        layout = {
          preset = "select",
        },
      },
      terminal = {
        win = {
          border = "rounded",
        },
      },
      styles = {
        notification = {
          border = "rounded",
          wo = {
            winblend = 10,
            wrap = false,
            conceallevel = 2,
            colorcolumn = "",
          },
        },
        notification_history = {
          border = "rounded",
          width = 0.6,
          height = 0.6,
          minimal = false,
          title = " Notification History ",
          title_pos = "center",
          backdrop = { transparent = true, blend = 25 },
          wo = {
            winhighlight = "Normal:SnacksNotifierHistory",
            winblend = 8,
          },
        },
        input = {
          border = "rounded",
          backdrop = 60,
          wo = {
            winblend = 8,
            winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
            cursorline = false,
          },
        },
      },
      notifier = {
        style = "compact",
        timeout = 3000,
        top_down = false,
        margin = { right = 0, bottom = 0 },
      },
    },
  },
}
