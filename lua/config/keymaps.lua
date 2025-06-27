-- Keymaps for call
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {desc = "Code: Actions" })
-- motion buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = "Reload current file" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find buffer" })

-- folders
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {desc = "Add workspace folder"})
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder"})
vim.keymap.set('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, {desc = "List workspace folders"})

vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {desc = "Show type definition"})

vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format { async = true }
end, {desc = "Format code"})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = "Show floating diagnostics"})
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, {desc = "Add diagnostic to the location list"})

-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {desc = "Code: Hover Documentation" })

-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {desc = "Code: Goto Definition" })

-- Set vim motion for <Space> + c + r to display references to the code under the cursor
vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, {desc = "Code: Goto References" })

-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
vim.keymap.set("n", "<leader>ci",require("telescope.builtin").lsp_implementations,{desc = "Code: Goto Implementations" })

-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, {desc = "Code: Rename" })

-- LazyGit
vim.keymap.set({'n', 'i'}, '<leader>lg', function()
  require('snacks').lazygit.open()
end, {desc = "LazyGit: open status repo."})

-- General mapping 
vim.g.mapleader = " "          -- leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Vim: Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Vim: Close window' })

-- Keymaps dashboard
vim.keymap.set('n', '<leader>in', function()
  require("snacks").dashboard.open()
end, {desc = 'Snacks: Return to the beginning'})

-- Keymaps tree
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd('NvimTreeOpen')
end, {desc = 'Nvimtree: Open Nvimtree'})
vim.keymap.set('n', '<leader>ct', function()
  vim.cmd('NvimTreeClose')
end, {desc = 'Nvimtree: Close Nvimtree'})

-- Keymaps treminal
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {desc = "Terminal: Escape terminal"})
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], {desc = "Terminal: Move left"})
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], {desc = "Terminal: Move down"})
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], {desc = "Terminal: Move up"})
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], {desc = "Terminal: Move right"})
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
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', {desc = "Buffer: Window vertical buffer"})
vim.keymap.set('n', '<leader>wh', ':split<cr>', {desc = "Buffer: Window horizontal buffer"})

-- Keymaps for Oil
vim.keymap.set('n', '<leader>oo', ':Oil<cr>', {desc = "Oil: open oil"})
vim.keymap.set('n', '<leader>of', require("oil").toggle_float, {desc = "Oil: open oil float"})

-- picker
vim.keymap.set('n', "<leader>pf", function() require("snacks").picker.files() end,
  {desc = "Picker: Find Files (Snacks Picker)"}
)
vim.keymap.set('n', "<leader>pc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end,
  {desc = "Picker: Find Config File"}
)
vim.keymap.set('n', "<leader>ps", function() require("snacks").picker.grep() end,
  {desc = "Picker: Grep word" }
)
vim.keymap.set({'n', 'x'}, "<leader>pws", function() require("snacks").picker.grep_word() end,
  {desc = "Picker: Search Visual selection or Word"}
)
vim.keymap.set('n', "<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end,
  {desc = "Picker: Search Keymaps (Snacks Picker)"}
)

