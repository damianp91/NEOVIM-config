
vim.api.nvim_set_hl(0, "mainColor", { fg = "#f6bf00", bold = true })
---@class snacks.dashboard.Config
return {
  width = 50,
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 16, -- empty columns between vertical panes
  autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
  -- These settings are used by some built-in sections
  preset = {
    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
    ---@type fun(cmd:string, opts:table)|nil
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your custom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = function()require('config.proyect_type').election_type()end},
      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
    -- Used by the `header` section
    header = [[
              ▄ ▄                                 
                      ▌  ▀▀▀▀▀         █▀▀█       
          ▐   █   █▄▄▄█▀▀█▄▌     ▀     █▄▄█   ▄   
        ▄▄█     ▄     ▄▄▄▄▄▄▄▄▄▌ ▐  ▌             
          █▄  ▄▄▄  ▌  █ ▄▄▄ █ ▄  █  █▄▄█  ▄█▀▀▄█  
          █ ▄ █▄█ ▄▄▄ █ █▄█ █ █  █   ▄  ▐     ▀   
       ▄▐ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █  █ ▀▀▀█▀▀ █▄▄▄ █  
       █▄▄▄▄█▄▄█ █▄█ █▄█▄█▄█▄█▄▄█ ▄▄▄▄▄▄▄▄▄▄▄▄█]],
  },
  -- item field formatters
  formats = {
    icon = function(item)
      if item.file and (item.icon == "file" or item.icon == "directory") then
        local icon = vim.fn.fnamemodify(item.file, ":t"):match("^%.") and "" or ""
        return {icon, width = 2, hl = "icon"}
      end
      return { item.icon, width = 2, hl = "icon" }
    end,
    footer = { "%s", align = "center", hl = "mainColor" },
    header = { "%s", align = "center", hl = "mainColor"},
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ":~")
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      if #fname > ctx.width then
        local dir = vim.fn.fnamemodify(fname, ":h")
        local file = vim.fn.fnamemodify(fname, ":t")
        if dir and file then
          file = file:sub(-(ctx.width - #dir - 2))
          fname = dir .. "/…" .. file
        end
      end
      local dir, file = fname:match("^(.*)/(.+)$")
      return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
    end,
  },
  sections = {
    -- Pane 1
    { section = "header", hl = "mainColor" },
    { section = "keys", gap = 1, padding = 1 },
    { section = "startup" },

    -- Pane 2
    {
      pane = 2,
      title =[[
      ▀ █ █ ▀   ▀ █ █ ▀   ▀ █ █ ▀   ▀ █ █ ▀   ▀ █ █ ▀   ▀ █ █ ▀
      ██   ██   ██   ██   ██   ██   ██   ██   ██   ██   ██   ██
      ▄ █ █ ▄   ▄ █ █ ▄   ▄ █ █ ▄   ▄ █ █ ▄   ▄ █ █ ▄   ▄ █ █ ▄
      ]],
      height = 5,
      padding = 1,
    },
    {
      pane = 2,
      icon = " ",
      title = "Recent Files",
      section = "recent_files",
      indent = 2,
      padding = 1,
    },
    {
      pane = 2,
      icon = " ",
      title = "Projects",
      section = "projects",
      indent = 2,
      padding = 1,
    },
    {
      pane = 2,
      icon = " ",
      title = "Git Status",
      section = "terminal",
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      cmd = "git status --short --branch --renames",
      height = 5,
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    },
  },
}
