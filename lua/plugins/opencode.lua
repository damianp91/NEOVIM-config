return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  event = "VeryLazy",
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
    vim.g.opencode_opts = {}

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set(
      { "n", "x" },
      "<C-o>", function() require("opencode").ask("@this: ",
        { submit = true })
      end,
      { desc = "OpenCode: Ask question…" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<C-x>",
      function() require("opencode").select() end,
      { desc = "OpenCode: Execute action…" }
    )
    vim.keymap.set(
      { "n", "t" },
      "<C-t>",
      function() require("opencode").toggle() end,
      { desc = "OpenCode: Toggle panel" }
    )
    vim.keymap.set(
      { "n", "x" },
      "ga",
      function() return require("opencode").operator("@this ") end,
      { desc = "OpenCode: Add range", expr = true }
    )
    vim.keymap.set(
      "n",
      "gA",
      function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "OpenCode: Add line", expr = true }
    )
    vim.keymap.set(
      "n",
      "<S-C-u>",
      function() require("opencode").command("session.half.page.up") end,
      { desc = "OpenCode: Scroll up" }
    )
    vim.keymap.set(
      "n",
      "<S-C-d>",
      function() require("opencode").command("session.half.page.down") end,
      { desc = "OpenCode: Scroll down" }
    )
    -- You may want these if you use the opinionated `<C-a>` and `<C-x>`
    -- keymaps above — otherwise consider `<leader>o…`
    -- (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set(
      "n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true }
    )
    vim.keymap.set(
      "n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true }
    )
  end,
}
