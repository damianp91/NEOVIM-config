return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    {
      {
        'tpope/vim-dadbod',
        lazy = true
      }
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql', 'redis' },
      lazy = true
    },
    'hrsh7th/nvim-cmp',
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_winwidth = 40
    vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<cr>', { desc = 'db: Toggle UI' })
    vim.keymap.set('n', '<leader>dq', '<cmd>DBUIHide<cr>', { desc = 'db: Quit UI' })
    vim.g.dbs = {
      nvim_user  = 'mysql://root:root@localhost:3306',
    }
  end,
  config = function()
    require('cmp').setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}
