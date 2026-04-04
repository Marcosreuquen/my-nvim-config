-- OpenCode AI integration
---@type LazySpec
return {
  {
    "nickjvandyke/opencode.nvim",
    lazy = false,
    version = "*",
    dependencies = {
      {
        ---@module "snacks"
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      local cmd = "opencode --port 54403"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = false,
          on_win = function(win) require("opencode.terminal").setup(win.win) end,
        },
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = false,
          stop = function() require("snacks.terminal").get(cmd, snacks_terminal_opts):close() end,
          toggle = function() require("snacks.terminal").toggle(cmd, snacks_terminal_opts) end,
        },
      }

      vim.o.autoread = true

      --- Build a file reference for `opencode run` from current buffer context.
      ---@return string file reference
      local function build_file_context()
        local buf = vim.api.nvim_get_current_buf()
        local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p:~")
        if filepath == "" then return "" end

        local mode = vim.fn.mode()
        if mode:match "[vV\22]" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
          local from = vim.api.nvim_buf_get_mark(buf, "<")
          local to = vim.api.nvim_buf_get_mark(buf, ">")
          if from[1] > to[1] or (from[1] == to[1] and from[2] > to[2]) then from, to = to, from end
          local is_line = mode == "V"
          return string.format(
            "%s:L%d%s-L%d%s",
            filepath,
            from[1],
            is_line and "" or string.format(":C%d", from[2]),
            to[1],
            is_line and "" or string.format(":C%d", to[2])
          )
        else
          local cursor = vim.api.nvim_win_get_cursor(0)
          return string.format("%s:L%d:C%d", filepath, cursor[1], cursor[2] + 1)
        end
      end

      --- One-shot ask: runs `opencode run` in a temp session and shows the response in a floating window.
      local function ask_temp()
        local file_ref = build_file_context()

        Snacks.input({ prompt = "Ask AI: " }, function(question)
          if not question or question == "" then return end

          local message = file_ref ~= "" and (file_ref .. " " .. question) or question
          local notif_id = vim.notify("Running opencode...", vim.log.levels.INFO, { title = "AI", timeout = 0 })

          local run_cmd = { "opencode", "run", "--title", "temp" }

          vim.system(
            { "opencode", "session", "list", "--format", "json", "--max-count", "50" },
            { text = true },
            function(list_obj)
              if list_obj.code == 0 and list_obj.stdout and list_obj.stdout ~= "" then
                local ok, sessions = pcall(vim.json.decode, list_obj.stdout)
                if ok and sessions then
                  for _, session in ipairs(sessions) do
                    if session.title == "temp" then
                      table.insert(run_cmd, "--session")
                      table.insert(run_cmd, session.id)
                      break
                    end
                  end
                end
              end
              table.insert(run_cmd, message)

              vim.system(run_cmd, { text = true }, function(obj)
                vim.schedule(function()
                  Snacks.notifier.hide(notif_id)

                  if obj.code ~= 0 then
                    vim.notify(
                      "opencode failed: " .. (obj.stderr or obj.stdout or "unknown error"),
                      vim.log.levels.ERROR,
                      { title = "AI" }
                    )
                    return
                  end

                  local response = obj.stdout or ""
                  if response == "" then
                    vim.notify("No response from AI", vim.log.levels.WARN, { title = "AI" })
                    return
                  end

                  local lines = vim.split(response, "\n")
                  local max_line_len = 0
                  for _, line in ipairs(lines) do
                    max_line_len = math.max(max_line_len, vim.fn.strdisplaywidth(line))
                  end
                  local editor_w = vim.o.columns
                  local editor_h = vim.o.lines
                  local w = math.max(40, math.min(max_line_len + 4, math.floor(editor_w * 0.75)))
                  local h = math.max(5, math.min(#lines + 2, math.floor(editor_h * 0.8)))

                  Snacks.win {
                    position = "float",
                    enter = true,
                    width = w,
                    height = h,
                    border = "rounded",
                    title = " AI Response ",
                    title_pos = "center",
                    ft = "markdown",
                    text = response,
                    wo = {
                      wrap = true,
                      linebreak = true,
                      conceallevel = 2,
                      spell = false,
                    },
                    bo = {
                      modifiable = false,
                    },
                    keys = {
                      q = "close",
                      ["<Esc>"] = "close",
                    },
                    backdrop = 60,
                  }
                end)
              end)
            end
          )
        end)
      end

      -- Keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", ask_temp, { desc = "Ask AI (temp session)" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action..." })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator "@this " end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator "@this " .. "_" end, { desc = "Add line to opencode", expr = true })
      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command "session.half.page.up" end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command "session.half.page.down" end, { desc = "Scroll opencode down" })
      vim.keymap.set("n", "<C-b>", function() require("custom/opencode_sessions").pick_session() end, { desc = "Pick opencode session" })
    end,
  },
}
