return {
  "lukas-reineke/virt-column.nvim",
  opts = {
    char = "│",
    virtcolumn = "85",
    exclude = {
      filetype = {
        '.json', '.MD'
      }
    }
  },
  event = "BufReadPost",
}

