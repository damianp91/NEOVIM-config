return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  {
    "NvChad/nvim-colorizer.lua",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function()
      local nvchadcolorizer = require("colorizer")
      local tailwindcolorizer = require("tailwindcss-colorizer-cmp")

      nvchadcolorizer.setup({
        options = {
          parsers = {
            css = true,
            tailwind = {enable = true},
          },
          display = {
            mode = "Virtualtext",
            virtualtext = {possition = "after"}
          },
        },
        filetypes = {
          "html",
          "css",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
          "vue",
          "svelte",
          "java",
          "lua"
        },
      })

      tailwindcolorizer.setup({
        color_square_width = 2,
      })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          vim.cmd("ColorizerAttachToBuffer")
        end,
      })

    end,
  },
}
