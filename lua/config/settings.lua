-- General Settings
vim.opt.number = true              -- Show number of every line command
vim.opt.relativenumber = true      -- Show relative number of actual line
vim.opt.tabstop = 2                -- Set the number of spaces for each tabstop
vim.opt.shiftwidth = 2             -- Set the number of spaces for each indent
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true    -- Colors in terminal
vim.opt.scrolloff = 8           -- 8 lines for each scroll
vim.opt.sidescrolloff = 8       -- 8 columns for lateral scroll
vim.opt.cursorline = true       -- Highlight actual line
vim.opt.showmatch = true
vim.opt.updatetime = 300        -- Waiting for events 

-- General mapping 
vim.g.mapleader = " "          -- leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })

-- Keymaps dashboard
vim.keymap.set('n', '<leader>in', function()
  require("snacks").dashboard.open()
end, {desc = 'alpha: Return to the beginning'})

-- Keymaps tree
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd('NvimTreeOpen')
end, {desc = 'nvimtree: Open Nvimtree'})
vim.keymap.set('n', '<leader>ct', function()
  vim.cmd('NvimTreeClose')
end, {desc = 'nvimtree: Close Nvimtree'})

-- Keymaps treminal
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {desc = "motion: Escape terminal"})
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], {desc = "motion: Move left"})
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], {desc = "motion: Move down"})
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], {desc = "motion: Move up"})
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], {desc = "motion: Move right"})
vim.keymap.set('n', '<leader>th', function()
  vim.cmd("ToggleTerm direction=horizontal")
end, {desc = "Terminal: open horozontal terminal"})
vim.keymap.set('n', '<leader>tv', function()
  vim.cmd("ToggleTerm direction=vertical")
end, {desc = "Terminal: open vertical terminal"})
vim.keymap.set('n', '<leader>tf', function()
  vim.cmd("ToggleTerm direction=float")
end, {desc = "Terminal: open float terminal"})

-- Keymaps for buffers
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', {desc = "buffer: Window vertical buffer"})
vim.keymap.set('n', '<leader>wh', ':split<cr>', {desc = "buffer: Window horizontal buffer"})

-- Keymaps for Oil
vim.keymap.set('n', '<leader>oo', ':Oil<cr>', {desc = "oil: open oil"})
vim.keymap.set('n', '<leader>of', ':Oil --float<cr>', {desc = "oil: open oil float"})

