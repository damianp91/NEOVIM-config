return {
  "nvim-lualine/lualine.nvim",
  dependecies = {"nvim-tree/nvim-web-devicons"},
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 1,
        }
      }
    },
    inactive_winbar = {
      lualine_c = {"filename"},
    },
  },
}
