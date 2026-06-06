--NOTE: ColorScheme setting view color

return {
  -- dir = "~/plugins-nvim/silicis.nvim",
  -- name = "silicis.nvim",
  "damianp91/silicis.nvim",
  priority = 1000,
  lazy = false,

  config = function()
    require("silicis").setup({
      transparent = {
        enabled = false,
      },
      integrations = {
        neotree = false,
        bufferline = false,
      },
      variant = "terra", -- "terra" | "cineris" | "pruna" | "algor"
    })

    vim.cmd.colorscheme("silicis")
  end,
}
