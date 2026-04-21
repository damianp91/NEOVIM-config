-- NOTE: IdentLine Shows vertical line for indentation
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      highlight = "IblIndent"
    },
    scope = {enabled = false},
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "dashboard",
        "lazy",
        "mason",
        "markdown"
      },
    }
  },
}
