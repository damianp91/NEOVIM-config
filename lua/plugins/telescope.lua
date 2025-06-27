
-- Configuration telescope
return {
  "nvim-telescope/telescope.nvim",
  event = 'VeryLazy',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        -- get access to telescopes navigation functions
        local actions = require("telescope.actions")

        require("telescope").setup({
          -- use ui-select dropdown as our ui
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {}
            }
          },
          -- set keymappings to navigate through items in the telescope io
          mappings = {
            i = {
              -- use <cltr> + n to go to the next option
              ["<C-n>"] = actions.cycle_history_next,
              -- use <cltr> + p to go to the previous option
              ["<C-p>"] = actions.cycle_history_prev,
              -- use <cltr> + j to go to the next preview
              ["<C-j>"] = actions.move_selection_next,
              -- use <cltr> + k to go to the previous preview
              ["<C-k>"] = actions.move_selection_previous,
            }
          },
          -- load the ui-select extension
          require("telescope").load_extension("ui-select")
        })
      end
    }
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- The default case_mode is "smart_case"
      },
    },
    defaults = {
      winblend = 15,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
    },
  },
  config = function(opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('fzf')
  end,
  keys = {
    {
      "<leader>pp",
      function()
        require('telescope.builtin').git_files({ show_untracked = true })
      end,
      desc = "Telescope Git Files",
    },
    {
      "<leader>pe",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Telescope buffers",
    },
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status()
      end,
      desc = "Telescope Git status",
    },
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_bcommits()
      end,
      desc = "Telescope Git commits",
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
      desc = "Telescope Git branches",
    },
    {
      "<leader>pf",
      function()
        require('telescope.builtin').find_files()
      end,
      desc = "Telescope Find Files",
    },
    {
      "<leader>ph",
       function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope Help"
    },
    {
      "<leader>bb",
      function()
        require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
      end,
      desc = "Telescope file browser"
    }
  },
}



