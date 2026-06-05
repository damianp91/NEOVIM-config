-- NOTE: Wilder Upper mode for view comand line
return {
  "gelguy/wilder.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "romgrk/fzy-lua-native",
  },
  event = "CmdlineEnter",
  config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })

    -- Define custom highlight groups

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({

        min_width = "35%",                -- minimum height of the popupmenu, can also be a number
        max_height = "30%",               -- to set a fixed height, set max_height to the same value
        reverse = 0,                      -- if 1, shows the candidates from bottom to top
        highlighter = {
          wilder.lua_pcre2_highlighter(), -- Requires luarocks install pcre2
          wilder.lua_fzy_highlighter(),   -- Requires fzy-lua-native
        },
        border = "rounded",
        left = {
          " ",
          wilder.popupmenu_devicons(),
        },

        right = {
          " ",
          wilder.popupmenu_scrollbar(),
        },
      }))
    )
  end,
}
