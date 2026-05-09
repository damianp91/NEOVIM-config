-- NOTE: Harpoon Quick list of favorite files on project.
return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    {
      "<leader>eh",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = "Harpoon Toggle Menu"
    },
    {
      "<S-m>",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      desc = "Harpoon Mark File"
    },
    {
      "<leader>en",
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      desc = "Harpoon: Navigate next mark"
    },
    {
      "<leader>ep",
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = "Harpoon: Navigate previous mark"
    },
  },
  config = function()
    require("harpoon").setup({})
  end
}
