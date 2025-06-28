-- General Settings
-- key leader
vim.g.mapleader = " "

-- numeration
vim.opt.number = true              -- Show number of every line command
vim.opt.relativenumber = true      -- Show relative number of actual line

-- indent
vim.opt.tabstop = 2                -- Set the number of spaces for each tabstop
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2             -- Set the number of spaces for each indent
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- search
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- colors
vim.opt.background = "dark"
vim.opt.termguicolors = true    -- Colors in terminal
vim.opt.showmatch = true
vim.opt.cursorline = true       -- Highlight actual line

-- scroll
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8           -- 8 lines for each scroll
vim.opt.sidescrolloff = 8       -- 8 columns for lateral scroll
vim.opt.updatetime = 100        -- Waiting for events 

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- edit
vim.g.editorconfig = true

-- sounds
vim.opt.errorbells = false
vim.opt.visualbell = true

-- backspace
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.showmode = false
