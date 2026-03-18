-- NOTE: IdentLine Shows vertical line for indentation
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = false },
  },
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "dashboard",
      "lazy",
      "mason",
    },
  }
}
