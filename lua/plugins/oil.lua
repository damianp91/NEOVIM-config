return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
        {
          "git_status",
          symbols = {
            added    = "",
            modified = "",
            deleted  = "",
          }
        },
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "yes",
        cursorcolumn = false,
        list = false,
        conceallevel = 2,
        concealcursor = "nvic",
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },
      constrain_cursor = "editable",
      watch_for_changes = true,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<TAB>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["go"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        header = false,
        case_insensitive = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
        is_always_hidden = function(name, _)
          return name == ".."
        end,
      },
      extra_scp_args = {},
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_hidden = true,
      },
      float = {
        padding = 1,
        max_width = 0.4,
        max_height = 0.7,
        border = "rounded",
        win_options = {
          winblend = 8,   -- (0-100) where 100 is invisible
        },
        preview_split = "auto",
        override = function(conf)
          local screen_w = vim.o.columns
          local screen_h = vim.o.lines
          local width = math.floor(screen_w * 0.6)
          local height = math.floor(screen_h * 0.5)
          local col = math.floor((screen_w - width) / 2)
          local row = math.floor((screen_h - height) / 2)
          conf.width = width
          conf.height = height
          conf.col = col
          conf.row = row
          return conf
        end,
      },
    })
  end,
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
}
