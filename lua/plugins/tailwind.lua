-- NOTE: TailWind show color Hex, css, etc.
return {
  {
    "NvChad/nvim-colorizer.lua",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local nvchadcolorizer = require("colorizer")
      local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

      -- Configuración de nvim-colorizer
      nvchadcolorizer.setup({
        filetypes = {
          "html", "css", "javascript", "typescript", "javascriptreact",
          "typescriptreact", "vue", "svelte", "lua"
        },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          hex_color = true,
          tailwind = true,
          mode = "virtualtext",
          virtualtext = " ",
        },
      })
      tailwindcolorizer.setup({
        color_square_width = 2,
      })
    end,
  },
}
