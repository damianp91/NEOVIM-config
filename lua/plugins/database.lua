return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion"
  },
  lazy = false,
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
   vim.g.dbs = {
      test_db = os.getenv("DB_TEST_URL"),
      datab_one_db = os.getenv("DB_DATABONE_URL")
    }
  end
}

