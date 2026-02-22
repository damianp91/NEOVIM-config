---@diagnostic disable: undefined-field
return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "tpope/vim-dotenv",
  },
  keys = {
    { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'db: Toggle UI' },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 50

    vim.g.db_ui_table_helpers = {
      mysql = {
        Count = "select count(1) from {optional_schema}{table}",
        Explain = "EXPLAIN {last_query}",
      },
      -- If I want to use sqlite
      -- sqlite = {
      --   Describe = "PRAGMA table_info({table})",
      -- },
    }

    -- Settings cmp
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {'sql', 'mysql', 'plsql'},
      callback = function()
        local cmp = require('cmp')
        cmp.setup.buffer {
          sources = {
            {name = 'vim-dadbod-completion'},
            {name = 'buffer'},
          }
        }
      end,
    })
  end,
}
