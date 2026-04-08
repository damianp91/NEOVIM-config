return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
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
    vim.o.autoread = true

    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open("opencode --port", {
            win = {
              position = "right",
              width = 45,
              enter = false,
            },
          })
        end,
        stop = function()
          local ok, term = pcall(require("snacks.terminal").get, "opencode --port")
          if ok then
            term:close()
          end
        end,
        toggle = function()
          local ok, term = pcall(require("snacks.terminal").get, "opencode --port")
          if ok then
            term:toggle()
          else
            require("snacks.terminal").open("opencode --port", {
              win = {
                position = "right",
                width = 45,
                enter = true,
              },
            })
          end
        end,
      },
    }

    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "OpenCode: Ask about selection" })

    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "OpenCode: Select action" })

    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "OpenCode: Toggle panel" })

    vim.keymap.set("n", "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "OpenCode: Operator", expr = true })

    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "OpenCode: Send line", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "OpenCode: Scroll up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "OpenCode: Scroll down" })

    vim.keymap.set("n", "+", "<C-a>", {
      desc = "Increment (disabled for opencode)", noremap = true
    })

    vim.keymap.set("n", "-", "<C-x>", {
      desc = "Decrement (disabled for opencode)", noremap = true
    })
  end,
}
