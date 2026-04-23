-- NOTE: Harpoon Quick list of favorite files on project.
return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    -- Set a vim motion to <Shift>m to mark a file with harpoon
    vim.keymap.set("n", "<S-m>", "<cmd>lua require('harpoon.mark').add_file()<cr>",
      {desc = "Harpoon Mark File"}
    )

    vim.keymap.set("n", "<leader>en",
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      { desc = "Harpoon: Navigate next mark" }
    )
    vim.keymap.set("n", "<leader>ep",
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      { desc = "Harpoon: Navigate previous mark" }
    )
    -- Set a vim motion to the tab key to open the harpoon menu to easily navigate
    -- frequented files
    vim.keymap.set("n", "<leader>eh",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      {desc = "Harpoon Toggle Menu"}
    )
  end
}
