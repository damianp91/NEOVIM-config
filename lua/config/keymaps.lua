local M = {}

function M.setup()
  -- General
  vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Vim: Save file' })
  vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Vim: Close window' })
  vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = "Vim: Reload current file" })

  -- Navegación de Buffers
  vim.keymap.set("n", "<S-l>", ":bnext<CR>", {desc = "Next buffer", silent = true})
  vim.keymap.set("n", "<S-h>", ":bprev<CR>",
    { desc = "Previous buffer", silent = true }
  )
  vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers,
    { desc = "Find buffer" }
  )
  vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>",
    { desc = "Close other buffers" }
  )
  vim.keymap.set('n', '<leader>wv', ':vsplit<cr>',
    { desc = "Buffer: Window vertical buffer" }
  )
  vim.keymap.set('n', '<leader>wh', ':split<cr>',
    { desc = "Buffer: Window horizontal buffer" }
  )

  -- Plugins
  -- LazyGit
  vim.keymap.set({'n', 'v'}, '<leader>lg',
    function() require('snacks').lazygit.open() end,
    { desc = "LazyGit: open status repo."}
  )

  -- Dashboard
  vim.keymap.set('n', '<leader>in', function() require("snacks").dashboard.open() end,
    { desc = 'Snacks: Return to the beginning' }
  )

  -- NvimTree
  vim.keymap.set('n', '<leader>ot', function() vim.cmd('NvimTreeOpen') end,
    { desc = 'Nvimtree: Open Nvimtree' }
  )
  vim.keymap.set('n', '<leader>ct', function() vim.cmd('NvimTreeClose') end,
    { desc = 'Nvimtree: Close Nvimtree' }
  )

  -- Oil
  vim.keymap.set('n', '<leader>oo', ':Oil<cr>', { desc = "Oil: open oil" })
  vim.keymap.set('n', '<leader>of', require("oil").toggle_float,
    { desc = "Oil: open oil float" }
  )

  -- which-key
  vim.keymap.set('n', "<leader>rw", function() require("which-key").setup() end,
    { desc = "Reload WhichKey" }
  )

  -- Terminal (ToggleTerm)
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],
    { desc = "Terminal: Escape terminal" }
  )
  vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]],
    { desc = "Terminal: Move left" }
  )
  vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]],
    { desc = "Terminal: Move down" }
  )
  vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]],
    { desc = "Terminal: Move up" }
  )
  vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]],
    { desc = "Terminal: Move right" }
  )
  vim.keymap.set('n', '<leader>th',
    function() vim.cmd("ToggleTerm direction=horizontal") end,
    { desc = "Terminal: open horozontal terminal" }
  )
  vim.keymap.set('n', '<leader>tv',
    function() vim.cmd("ToggleTerm direction=vertical") end,
    { desc = "Terminal: open vertical terminal" }
  )
  vim.keymap.set('n', '<leader>tf',
    function() vim.cmd("ToggleTerm direction=float") end,
    { desc = "Terminal: open float terminal" }
  )

  -- Picker (Telescope / Snacks)
  vim.keymap.set('n', "<leader>pf", function() require("snacks").picker.files() end,
    { desc = "Picker: Find Files" }
  )
  vim.keymap.set('n', "<leader>pc",
    function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Picker: Find Config File" }
  )
  vim.keymap.set('n', "<leader>ps", function() require("snacks").picker.grep() end,
    { desc = "Picker: Grep word" }
  )
  vim.keymap.set({'n', 'x'}, "<leader>pws",
    function() require("snacks").picker.grep_word() end,
    { desc = "Picker: Search Visual selection or Word" }
  )
  vim.keymap.set('n', "<leader>pk",
    function() require("snacks").picker.keymaps({ layout = "ivy" }) end,
    { desc = "Picker: Search Keymaps" }
  )

  -- Obsidian
  vim.keymap.set("n", "<leader>ow", ":ObsidianWorkspace<CR>",
    { desc = "Obsidian: Switch workspace" }
  )
  vim.keymap.set("n", "<leader>oa", ":ObsidianOpen<CR>",
    { desc = "Obsidian: Open in Obsidian app" }
  )
  vim.keymap.set("n", "<leader>on", ":ObsidianNew ",
    { desc = "Obsidian: New note" }
  )
  vim.keymap.set("n", "<leader>oy", ":ObsidianToday<CR>",
    { desc = "Obsidian: Daily note" }
  )
  vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>",
    { desc = "Obsidian: Search notes" }
  )
  vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>",
    { desc = "Obsidian: Switch note" }
  )

  -- Comment
  vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)",
    { desc = "Comment Line" }
  )
  vim.keymap.set("v", "<leader>c", "<Plug>(comment_toggle_linewise_visual)",
    { desc = "Comment Selected" }
  )
end

-- Todos estos atajos serán locales a ese buffer.
function M.lsp_keymaps(_, bufnr)
  -- La opción `buffer = bufnr` asegura que el atajo solo exista en este buffer.
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Atajos de LSP
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
    vim.tbl_extend('force', opts, { desc = 'LSP: Code Action' })
  )
  vim.keymap.set('n', 'K', vim.lsp.buf.hover,
    vim.tbl_extend('force', opts, { desc = 'LSP: Hover Documentation'})
  )
  vim.keymap.set("n", "gd", vim.lsp.buf.definition,
    vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition'})
  )
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
    vim.tbl_extend('force', opts, { desc = 'LSP: Go to Declaration'})
  )
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    vim.tbl_extend('force', opts, { desc = 'LSP: Go to Implementation'})
  )
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
    vim.tbl_extend('force', opts, { desc = 'LSP: Go to Type Definition'})
  )
  vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
    vim.tbl_extend('force', opts, { desc = 'LSP: Find References (Telescope)'})
  )
  vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename,
    vim.tbl_extend('force', opts, { desc = 'LSP: Rename Symbol'})
  )

  -- Workspace
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
    vim.tbl_extend('force', opts, { desc = 'LSP: Add Workspace Folder'})
  )
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    vim.tbl_extend('force', opts, { desc = 'LSP: Remove Workspace Folder'})
  )
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend('force', opts, { desc = 'LSP: List Workspace Folders'}))

  -- Formato y Diagnósticos
  vim.keymap.set('n', '<leader>f',
    function() vim.lsp.buf.format { async = true } end,
    vim.tbl_extend('force', opts, { desc = 'LSP: Format Code (Async)'})
  )
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
    vim.tbl_extend('force', opts, { desc = 'Diagnostic: Show Hover'})
  )
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto(true) end,
    vim.tbl_extend('force', opts, { desc = 'Diagnostic: Previous'})
  )
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto(false) end,
    vim.tbl_extend('force', opts, { desc = 'Diagnostic: Next'})
  )
  vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = 'Diagnostic: Set Location List'})
  )
end

return M
