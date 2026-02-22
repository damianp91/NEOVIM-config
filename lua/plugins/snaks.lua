return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = {enabled = true},
    bigfile = require("config.config_snaks.conf_bigfile"),
    dashboard = require("config.config_snaks.conf_dashboard"),
    bufdelete = {enabled = true},
    dim = {enabled = false},
    explorer = { enabled = true },
    git = {enabled = true},
    image = require("config.config_snaks.conf_image"),
    picker = require("config.config_snaks.conf_picker"),
    indent = {enabled = true},
    input = {enabled = true},
    layout = {enabled = true},
    lazygit = {enabled = true},
    scratch = {enabled = true},
    notifier = {enabled = true},
    quickfile = {enabled = true},
    scope = {enabled = true},
    scroll = {enabled = true},
    statuscolumn = {enabled = true},
    words = {enabled = true},
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    vim.api.nvim_set_hl(0, "SnacksPickerListNormal",   { bg = "#161616" })
    vim.api.nvim_set_hl(0, "SnacksPickerPreviewNormal",{ bg = "#161616" })
    vim.api.nvim_set_hl(0, "SnacksPickerInputNormal",  { bg = "#161616" })
    vim.api.nvim_set_hl(0, "SnacksPickerListBorder",   { fg = "#d4c7b9",
      bg = "#161616" }
    )
    vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder",{ fg = "#d4c7b9",
      bg = "#161616" }
    )
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",  { fg = "#d4c7b9",
      bg = "#161616" }
    )
  end,
}
