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
      -- Enables the `snacks` terminal provider for opencode
      terminal = {
        win = {
          border = "rounded",
        },
      },
    },
  },
}
