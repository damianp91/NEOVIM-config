return {
  "lukas-reineke/virt-column.nvim",
  opts = {
    char = "│",
    virtcolumn = "85",
    exclude = {
      filetypes = {
        '.json', '.md'
      }
    }
  },
  event = "BufReadPost",
}

