-- NOTE: GitSigns. Configuration for signs of state edit in the side left
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    numhl = true,
    max_file_length = 10000,
  }
}
