
return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {

      " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New File", ":lua require('config.proyect_type').file_project()<CR>"),
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("h", "󰋗  Help Info", ":Telescope help_tags<CR>"),
      dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
    }

    local alpha = require("alpha")
    local layout = {
      { type = "padding", val = 12 },       -- Top space
      dashboard.section.header,
      { type = "padding", val = 2 },        -- Space between heater an botton
      dashboard.section.buttons,
      { type = "padding", val = 1 },        -- Space between los botton and footer
      dashboard.section.footer,
    }

    dashboard.config.layout = layout
    alpha.setup(dashboard.config)
  end,
}

