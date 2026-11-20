-- NOTE: TreeSitter Parser for each lenguage of the list ensure:installed

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").setup({})

      -- Highlight + indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf

          -- Syntax highlighting
          pcall(vim.treesitter.start, buf)

          -- Treesitter indentation
          vim.bo[buf].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Install parsers
      require("nvim-treesitter").install({
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
        "bash",
        "yaml",
        "json",
        "toml",
        "dockerfile",
        "rust",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      local textobjects = require("nvim-treesitter-textobjects")

      textobjects.setup({
        select = {
          lookahead = true,
        },

        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Textobjects: select
      local select_keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }

      for key, query in pairs(select_keymaps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      -- Textobjects: move next start
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end)

      -- Textobjects: move next end
      vim.keymap.set({ "n", "x", "o" }, "]F", function()
        move.goto_next_end("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]C", function()
        move.goto_next_end("@class.outer", "textobjects")
      end)

      -- Textobjects: move previous start
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end)

      -- Textobjects: move previous end
      vim.keymap.set({ "n", "x", "o" }, "[F", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "[C", function()
        move.goto_previous_end("@class.outer", "textobjects")
      end)

      -- Textobjects: swap parameters
      vim.keymap.set("n", "<leader>a", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap parameter with next" })

      vim.keymap.set("n", "<leader>A", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap parameter with previous" })

      -- Incremental selection (Neovim native)
      vim.keymap.set("n", "<C-space>", function()
        vim.treesitter.select("parent")
      end, { desc = "Treesitter: start selection" })

      vim.keymap.set("x", "<C-space>", function()
        vim.treesitter.select("parent")
      end, { desc = "Treesitter: expand selection" })

      vim.keymap.set("x", "<C-s>", function()
        vim.treesitter.select("parent")
      end, { desc = "Treesitter: expand to scope" })

      vim.keymap.set("x", "<C-BS>", function()
        vim.treesitter.select("child")
      end, { desc = "Treesitter: shrink selection" })
    end,
  },
}
