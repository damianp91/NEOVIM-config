return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  opts =  {
    presets = {
      bottom_search = false,        -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true,            -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      format = {
        cmdline = { pattern = "^:", icon = " :", lang = "vim" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "󰮦 :" },
        search_down = {
          kind = "search", pattern = "^/",
          icon = " ", lang = "regex"
        },
        search_up = {
          kind = "search",
          pattern = "^%?",
          icon = " ",
          lang = "regex"
        },
        filter = { pattern = "^:%s*!", icon = " :", lang = "bash" },
        lua = {
          pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
          icon = " :", lang = "lua"
        },
        input = { icon = "󰥻 :" },
      },
    },
    messages = {
        enabled = true,
        view = "mini",
        view_error = "notify",
        view_warn = "notify",
    },
    lsp = {
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
      },
      signature = {
        enabled = true,
        auto_open = { enabled = false },
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,     -- requires hrsh7th/nvim-cmp
      },
      hover = { enabled = true, silent = false },
    },
    routes = {
      {
        filter = {
          event = "lsp",
          any = {
            { find = "markdown" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+ lines yanked" },
            { find = "%d+ lines yanked into register %w" },
          },
        },
        opts = { silent = true }, -- Evita que se guarde en el historial de mensajes
        view = "notify",
      },
      {
        filter = {
          event = "msg_show",
          kind = "progress",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "search",
        },
        view = "cmdline_popup",
      },
      {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        opts = { skip = true},
      },
      {
        filter = {
          event = "msg_show",
          find = "E%d+:",
        },
        view = "notify",
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+ fewer lines"},
            { find = "%d+ more lines"},
          },
        },
        opts = { skip = true },
      },
    },
    health = { checker = true },  -- Verifica salud del plugin
    throttle = 50,                -- Reduce updates innecesarios
  },
}
