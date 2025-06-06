return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = {enabled = true},
    bigfile = require("config.config_snaks.conf_bigfile"),
    dashboard = require("config.config_snaks.conf_dashboard"),
    bufdelete = {enabled = true},
    dim = {enabled = true},
    explorer = { enabled = true },
    git = {enabled = true},
    image = require("config.config_snaks.conf_image"),
    indent = {enabled = true},
    layout = {enabled = true},
    lazygit = {enabled = true},
    scratch = {enabled = true},
    picker = {enabled = true},
    notifier = {enabled = true},
    quickfile = {enabled = true},
    scope = {enabled = true},
    scroll = {enabled = true},
    statuscolumn = {enabled = true},
    words = {enabled = true},
  },
}
