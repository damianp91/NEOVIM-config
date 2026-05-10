-- NOTE: FUgitive Congigurations for git as well we use gitsigns
return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git" },
  keys = {
    { "<leader>ga", "<cmd>Git fetch --all -p<cr>", desc = "Git fetch" },
    { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" }
  },
}
