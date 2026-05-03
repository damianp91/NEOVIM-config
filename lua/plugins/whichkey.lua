-- NOTE: WhichKey Interactive map of keymaps 
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    -- Delay before showing the popup. Can be a number or a function that
    -- returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    proxy = { "auto" },
    -- filter = function(mapping)
    --   -- example to exclude mappings without a description
    --   return mapping.desc and mapping.desc ~= ""
    -- end,
    --- You can add any mappings here, or use `require('which-key').add()` later
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>C", group = "Comment"},
      { "<leader>c", group = "Code" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git" },
      { "<leader>n", group = "Notes" },
      { "<leader>p", group = "Pickers" },
      { "<leader>t", group = "Terminal" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Windows" },
      { "<leader>d", group = "Debug" },
      { "<leader>D", group = "DataBase" },
      { "<leader>T", group = "Trouble" },
    },
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- Which-key automatically sets up triggers for your mappings.
    -- But you can disable this and setup the triggers manually.
    -- Check the docs for more info.
    triggers = {
      { "<auto>", mode = "nxso" },
    },
    -- Start hidden and wait for a key to be pressed before showing the popup
    -- Only used by enabled xo mapping modes.
    ---@param ctx { mode: string, operator: string }
    defer = function(ctx)
      return ctx.mode == "V" or ctx.mode == "<C-V>"
    end,
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true,
      -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = true,
        -- enabling this will show WhichKey when pressing z= to select spelling
        -- suggestions
        suggestions = 30, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true,
        -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    ---@diagnostic disable: missing-fields
    win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = true,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      border = "rounded",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        winblend = 8,
        -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      width = {min = 20}, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    keys = {
      scroll_down = "<C-d>", -- binding to scroll down inside the popup
      scroll_up = "<C-u>", -- binding to scroll up inside the popup
    },
    --- Mappings are sorted using configured sorters and natural sort of the keys
    --- Available sorters:
    --- * local: buffer-local mappings first
    --- * order: order of the items (Used by plugins like marks / registers)
    --- * group: groups last
    --- * alphanum: alpha-numerical first
    --- * mod: special modifier keys last
    --- * manual: the order the mappings were added
    --- * case: lower-case first
    sort = { "local", "order", "group", "alphanum", "mod" },
    expand = 0, -- expand groups when <= n mappings
    -- expand = function(node)
    --   return not node.desc -- expand all nodes without a description
    -- end,
    -- Functions/Lua Patterns for formatting the labels
    ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
        -- { "<Space>", "SPC" },
      },
      desc = {
        { "<Plug>%(?(.*)%)?", "%1" },
        { "^%+", "" },
        { "<[cC]md>", "" },
        { "<[cC][rR]>", "" },
        { "<[sS]ilent>", "" },
        { "^lua%s+", "" },
        { "^call%s+", "" },
        { "^:%s*", "" },
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "󰦅 ",
      ellipsis = "…",
      mappings = true,
      rules = {
        { pattern = "buffer", icon = " ", color = "cyan" },
        { pattern = "file", icon = "󰈔 ", color = "cyan" },
        { pattern = "terminal", icon = " ", color = "red" },
        { pattern = "find", icon = "󰄉 ", color = "green" },
        { pattern = "search", icon = "󰄉 ", color = "green" },
        { pattern = "code", icon = " ", color = "orange" },
        { pattern = "window", icon = " ", color = "green" },
        { pattern = "diagnostic", icon = "󰒡 ", color = "green" },
        { pattern = "format", icon = "󰴑 ", color = "cyan" },
        { pattern = "debug", icon = "󰃤 ", color = "red" },
        { pattern = "git", icon = "󰊢 ", color = "orange" },
        { pattern = "notes", icon = "󰠮 ", color = "yellow" },
        { pattern = "picker", icon = "󰩵 ", color = "purple" },
        { pattern = "toggle", icon = " ", color = "yellow" },
        { pattern = "session", icon = "󰰢 ", color = "azure" },
        { pattern = "explorer", icon = " ", color = "cyan" },
        { pattern = "opencode", icon = "󰅴 ", color = "green" },
        { pattern = "database", icon = " ", color = "blue"},
        { pattern = "trouble", icon = "󰒡 ", color = "red"},
        { pattern = "keymaps", icon = " ", color = "purple"},
        { pattern = "comment", icon = " ", color = "blue" }
      },
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },
    show_help = true,
    -- show a help message in the command line for using WhichKey
    show_keys = true,
    -- show the currently pressed key and its label as a message in the command line
    -- disable WhichKey for certain buf types and file types.
    disable = {
      ft = {},
      bt = {},
    },
    debug = false, -- enable wk.log in the current directory
  },
  -- config = function()
  --   require("which-key").setup()
  -- end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show()
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
