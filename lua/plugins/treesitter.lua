-- NOTE: TreeSitter Parser for each lenguage of the list ensure:installed
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  opts = {
    ensure_installed = {
      "lua",
      "luadoc",
      "python",
      "javascript",
      "html",
      "css",
      "java",
      "c",
      "vim",
      "vimdoc",
      "sql",
      "markdown",
      "markdown_inline",
      "typescript",
    },
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
    },
  },
}
