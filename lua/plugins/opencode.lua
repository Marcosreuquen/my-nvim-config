return {
  {
    "nickjvandyke/opencode.nvim",
    lazy = false,
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
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
      -- TODO: Revisar la posibilidad de crear sessiones con puerto dinamico para poder tener varias sessiones abiertas a la vez. El tema es que el comando `opencode` no tiene una opción para especificar el puerto al crear una session, pero si se podría hacer algo como `OPENCODE_PORT=54404 opencode` para crear una session en un puerto específico. Habría que revisar si esto funciona correctamente y si se puede integrar en la configuración de este plugin.
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = false,
          on_win = function(win)
            require("opencode.terminal").setup(win.win)
          end,
        },
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = false,
          stop = function()
            require("snacks.terminal").get(cmd, snacks_terminal_opts):close()
          end,
          toggle = function()
            require("snacks.terminal").toggle(cmd, snacks_terminal_opts)
          end,
        },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      --- Build a file reference for `opencode run` from current buffer context.
      --- Replicates what `@this` does in the plugin's context system.
      ---@return string file reference (e.g. "~/project/file.lua:L10:C5-L20:C15")
      local function build_file_context()
        local buf = vim.api.nvim_get_current_buf()
        local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p:~")
        if filepath == "" then return "" end

        local mode = vim.fn.mode()
        if mode:match("[vV\22]") then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
          local from = vim.api.nvim_buf_get_mark(buf, "<")
          local to = vim.api.nvim_buf_get_mark(buf, ">")
          if from[1] > to[1] or (from[1] == to[1] and from[2] > to[2]) then
            from, to = to, from
          end
          local is_line = mode == "V"
          return string.format("%s:L%d%s-L%d%s",
            filepath,
            from[1], is_line and "" or string.format(":C%d", from[2]),
            to[1], is_line and "" or string.format(":C%d", to[2]))
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

          -- Show a loading notification
          local notif_id = vim.notify("Running opencode…", vim.log.levels.INFO, { title = "AI", timeout = 0 })

          -- Build the command
          local run_cmd = { "opencode", "run", "--title", "temp" }

          -- Check for existing temp session (async)
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

              -- Execute the query
              vim.system(run_cmd, { text = true }, function(obj)
                vim.schedule(function()
                  -- Dismiss the loading notification
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

                  -- Calculate dynamic dimensions based on content
                  local lines = vim.split(response, "\n")
                  local max_line_len = 0
                  for _, line in ipairs(lines) do
                    max_line_len = math.max(max_line_len, vim.fn.strdisplaywidth(line))
                  end
                  local editor_w = vim.o.columns
                  local editor_h = vim.o.lines
                  -- Clamp to min/max (absolute values — Snacks.win min_*/max_* don't resolve relative floats)
                  local w = math.max(40, math.min(max_line_len + 4, math.floor(editor_w * 0.75)))
                  local h = math.max(5, math.min(#lines + 2, math.floor(editor_h * 0.8)))

                  Snacks.win({
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
                  })
                end)
              end)
            end
          )
        end)
      end

      -- Keymaps
      
      -- Quick ask AI with context from current line/selection. Uses a temp session and shows response in a floating window.
      vim.keymap.set({ "n", "x" }, "<C-a>", ask_temp, { desc = "Ask AI (temp session)" })

      -- Execute opencode action on current line/selection. Opens the session picker if no active session.
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })

      -- Open opencode session
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

      -- Add current line/selection to the active opencode session's context..
      vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      -- Scroll opencode session (when focused) with Shift+Ctrl+Up/Down. 
      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

      -- Open project previous session picker with Ctrl+b.  
      vim.keymap.set("n", "<C-b>", function() require("custom/opencode_sessions").pick_session() end, { desc = "Pick opencode session" })
    end,
  }
}
