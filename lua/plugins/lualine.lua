-- NOTE: LuaLine status the neovim (MODE, Git, File... etc)
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      component_separators = {left = '│', right = '│'},
      section_separators = {left = '█', right = '█'},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          icon = '',
        }
      },
      lualine_b = {
        {
          'branch',
        },
        'diff',
        'diagnostics'
      },
      lualine_c = {
        {
          'filename',
          icon = '',
          file_status = true,
          newfile_status = false,
          path = 1,
          shorting_target = 40,
          symbols = {
            modified = '󰐼 ',
            readonly = '',
            unnamed = '[No Name]',
            newfile = ' ',
          }
        },
      },
      lualine_x = {'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'},
      inactive_sections = { },
      tabline = { },
      winbar = { },
      inactive_winbar = { },
      extensions = { }
    }
  },
}
