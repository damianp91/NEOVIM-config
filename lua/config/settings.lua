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
-- vim.opt.wrap = false            -- Desactiva el ajuste de línea (líneas largas no se ajustan)
vim.opt.cursorline = true       -- Highlight actual line
vim.opt.showmatch = true        
vim.opt.updatetime = 300       -- Tiempo de espera para eventos (reducción de latencia)

-- General mapping 
vim.g.mapleader = " "          -- leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Guardar archivo' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Cerrar ventana' })

