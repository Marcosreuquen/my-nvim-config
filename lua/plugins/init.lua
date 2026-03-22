return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = function(term)
          return math.floor(vim.o.lines * 0.3) -- 30% de la pantalla
        end,
        highlights = {
          Normal = { guibg = "NONE" },
          NormalNC = { guibg = "NONE" },
          NormalFloat = { guibg = "NONE" },
        },
        on_open = function(term)
          -- Padding visual: espacio arriba/abajo y a los lados
          vim.opt_local.scrolloff = 2
          vim.opt_local.sidescrolloff = 4
        end,
      })

      -- Sistema de tabs para terminales
      require("configs.term_tabs").setup()

      -- normal mode (el <C-t> ahora lo gestiona term_tabs.setup())
      -- terminal mode
      vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true, silent = true})
    
      -- agrandar terminal (C-= porque C-+ no lo reconocen todos los terminales)
      vim.keymap.set({"n", "t"}, "<C-=>", function()
        vim.cmd("resize +5")
      end, { noremap = true, silent = true })

      -- achicar terminal
      vim.keymap.set({"n", "t"}, "<C-->", function()
        vim.cmd("resize -5")
      end, { noremap = true, silent = true })

    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,   -- Show hidden files
          git_ignored = false -- Show files ignored by Git
        },
        git = {
          enable = true,
          ignore = false,  -- Dont hide ignored files
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
                -- Buscar una ventana que sea un buffer normal (no terminal, no nvim-tree, no special)
                local wins = vim.api.nvim_tabpage_list_wins(0)
                for _, win in ipairs(wins) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  local bt = vim.bo[buf].buftype
                  local ft = vim.bo[buf].filetype
                  if bt == "" and ft ~= "NvimTree" then
                    return win
                  end
                end
                -- Si no hay ventana válida, crear un split a la derecha del tree
                vim.cmd("wincmd l")
                vim.cmd("vsplit")
                return vim.api.nvim_get_current_win()
              end,
            },
          },
        },
      })
    end
  },
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- icons
  {
    "nvim-tree/nvim-web-devicons",
  },
  -- explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-web-devicons" }
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   lazy = false,
  --   dependencies = {
  --         { "nvim-lua/plenary.nvim", branch = "master" },
  --       },
  --   opts = require "configs.copilot_chat"
  -- },
  -- {
  --   "coder/claudecode.nvim",
  --   lazy = false,
  --   dependencies = { "folke/snacks.nvim" },
  --   config = true,
  --   keys = {
  --     { "<leader>a", nil, desc = "AI/Claude Code" },
  --     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
  --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
  --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  --     { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
  --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
  --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  --     {
  --       "<leader>as",
  --       "<cmd>ClaudeCodeTreeAdd<cr>",
  --       desc = "Add file",
  --       ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
  --     },
  --     -- Diff management
  --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
  --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  --   },
  -- }
}
