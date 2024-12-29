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
vim.opt.wrap = true            -- Desactiva el ajuste de línea (líneas largas no se ajustan)
vim.opt.cursorline = true       -- Highlight actual line
vim.opt.showmatch = true
vim.opt.updatetime = 300       -- Tiempo de espera para eventos (reducción de latencia)

-- General mapping 
vim.g.mapleader = " "          -- leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })

-- Keymaps tree
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd('NvimTreeOpen')
end, {desc = 'Open Nvim tree'})

vim.keymap.set('n', '<leader>ct', function()
  vim.cmd('NvimTreeClose')
end, {desc = 'Close nvim tree'})

-- Keymaps treminal
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {desc = 'Escape terminal'})
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], {desc = "Move left"})
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], {desc = "Move down"})
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], {desc = "Move up"})
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], {desc = "Move right"})

-- Keymaps for buffers
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', {desc = "Window vertical buffer"})
vim.keymap.set('n', '<leader>wh', ':split<cr>', {desc = "Window horizontal buffer"})


