-- NOTE: Snack List plugins to use
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = require("core.config_snacks.bigfile"),
    dashboard = require("core.config_snacks.dashboard"),
    bufdelete = { enabled = true },
    dim = { enabled = false },
    explorer = { enabled = false },
    git = { enabled = true },
    image = require("core.config_snacks.image"),
    picker = require("core.config_snacks.picker"),
    indent = { enabled = true },
    input = { enabled = true },
    layout = { enabled = true },
    lazygit = { enabled = true },
    scratch = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

  end,
}
