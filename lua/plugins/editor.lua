return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        view = {
          width = 35,
          side = "left",
          adaptive_size = false,
        },
        renderer = {
          highlight_git = true,
          root_folder_label = false,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = true,
              picker = function()
                local wins = vim.api.nvim_tabpage_list_wins(0)
                for _, win in ipairs(wins) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  local bt = vim.bo[buf].buftype
                  local ft = vim.bo[buf].filetype
                  if bt == "" and ft ~= "NvimTree" then
                    return win
                  end
                end
                vim.cmd "wincmd l"
                vim.cmd "vsplit"
                return vim.api.nvim_get_current_win()
              end,
            },
          },
        },
      }
    end,
  },
}
