

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
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  Open Session", ":SessionManager load_session<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    local alpha = require("alpha")
    local layout = {
      { type = "padding", val = 10 }, -- Espaciado superior
      dashboard.section.header,
      { type = "padding", val = 2 }, -- Espaciado entre el header y botones
      dashboard.section.buttons,
      { type = "padding", val = 1 }, -- Espaciado entre los botones y footer
      dashboard.section.footer,
    }

    dashboard.config.layout = layout
    alpha.setup(dashboard.config)
  end,
}




