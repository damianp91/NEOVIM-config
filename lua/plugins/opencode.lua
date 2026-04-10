return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  config = function()
    vim.o.autoread = true

    vim.g.opencode_opts = {
      server = {
        start = function()
          local Terminal = require("toggleterm.terminal").Terminal
          local term = Terminal:new({
            cmd = "opencode --port",
            direction = "vertical",
            size = 80,
            id = "opencode",
          })
          term:open()
        end,
        stop = function()
          local terms = require("toggleterm.terminal")
          local term = terms.find(function(t) return t.id == "opencode" end)
          if term then
            term:close()
          end
        end,
        toggle = function()
          local Terminal = require("toggleterm.terminal").Terminal
          local term = Terminal:new({
            cmd = "opencode --port",
            direction = "vertical",
            size = 80,
            id = "opencode",
          })
          term:toggle()
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
