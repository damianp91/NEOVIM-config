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
        is_hidden_file = function(name, _)
          local m = name:match("^%.")
          return m ~= nil
        end,
        show_absolute_path_on_root = false,
        natural_order = "fast",
        case_insensitive = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      extra_scp_args = {},
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_hidden = true,
      },
      experimental_watch_for_changes = {
        enable = true,
        debounce_ms = 300,
      },
      float = {
        padding = 1,
        max_width = 0.5,
        max_height = 0.7,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
        preview_split = "auto",
        override = function(conf)
          local screen_w = vim.o.columns
          local screen_h = vim.o.lines
          local width = math.floor(screen_w * 0.4)
          local height = math.floor(screen_h * 0.6)
          local col = math.floor(screen_w - width - (screen_w * 0.0))
          local row = math.floor((screen_h - height) / 2 - 2)
          conf.width = width
          conf.height = height
          conf.col = col
          conf.row = math.max(row, 0)
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

