-- NOTE: TreeSitter Parser for each lenguage of the list ensure:installed
return {
  "nvim-treesitter/nvim-treesitter",
  version = "v0.9.2",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
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
      "typescript",
      "bash",
      "yaml",
      "json",
      "toml",
      "dockerfile",
      "rust"
    },
    auto_install = true,
    highlight = {
      enable = true,
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
      move = {
        enable = true,
        set_jumps = true, -- guarda en jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-backspace>",
      },
    }
  },
}
