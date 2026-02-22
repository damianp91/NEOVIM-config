local M = {}

function M.setup()
  --NOTE: General
  vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Vim: Save file' })
  vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Vim: Close window' })
  vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = "Vim: Reload current file" })

  --NOTE: Navegación de Buffers
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

  --NOTE: Plugins
  -- LazyGit
  vim.keymap.set({'n', 'v'}, '<leader>lg',
    function() require('snacks').lazygit.open() end,
    { desc = "LazyGit: open status repo."}
  )

  --NOTE: Dashboard
  vim.keymap.set('n', '<leader>in', function() require("snacks").dashboard.open() end,
    { desc = 'Snacks: Return to the beginning' }
  )

  --NOTE: NvimTree
  vim.keymap.set('n', '<leader>ot', function() vim.cmd('NvimTreeOpen') end,
    { desc = 'Nvimtree: Open Nvimtree' }
  )
  vim.keymap.set('n', '<leader>ct', function() vim.cmd('NvimTreeClose') end,
    { desc = 'Nvimtree: Close Nvimtree' }
  )

  --NOTE: Oil
  vim.keymap.set('n', '<leader>oo', ':Oil<cr>', { desc = "Oil: open oil" })
  vim.keymap.set('n', '<leader>of', require("oil").toggle_float,
    { desc = "Oil: open oil float" }
  )

  --NOTE: which-key
  vim.keymap.set('n', "<leader>rw", function() require("which-key").setup() end,
    { desc = "Reload WhichKey" }
  )

  --NOTE: Terminal (ToggleTerm)
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

  --NOTE: Picker (Telescope / Snacks)
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

  --NOTE: Obsidian
  local function create_note(base_path, prompt_text)
    return function()
      local input = vim.fn.input(prompt_text)
      if input ~= "" then
        local full_path = base_path .. input .. ".md"
        vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")
        vim.cmd("edit " .. full_path)
      end
    end
  end
  vim.keymap.set("n", "<leader>ow", ":ObsidianWorkspace<CR>",
    { desc = "Obsidian: Switch workspace" }
  )
  vim.keymap.set("n", "<leader>oa", ":ObsidianOpen<CR>",
    { desc = "Obsidian: Open in Obsidian app" }
  )
  -- commands for notes
  vim.keymap.set("n", "<leader>on",
    create_note(vim.fn.expand("~/vaults/personal/notes/"), "Quick personal note: "),
    { desc = "Obsidian: New personal note" }
  )
  vim.keymap.set("n", "<leader>ob",
    create_note(vim.fn.expand("~/vaults/personal/second-brain/"),
      "Brain (ej: languages/java): "
    ),
    { desc = "Obsidian: New note to second-brain" }
  )
  vim.keymap.set("n", "<leader>oW",
    create_note(vim.fn.expand("~/vaults/work/notes/"), "Work (ej: tasks/bug-123): "),
    { desc = "Obsidian: New note work" }
  )
  vim.keymap.set("n", "<leader>oyp",
    function()
      vim.cmd("ObsidianWorkspace personal")
      vim.defer_fn(function()
        vim.cmd("ObsidianToday")
      end, 100)
    end, { desc = "Obsidian: Daily personal" }
  )
  vim.keymap.set("n", "<leader>oyw",
    function()
      vim.cmd("ObsidianWorkspace work")
      vim.defer_fn(function()
        vim.cmd("ObsidianToday")
      end, 100)
    end, { desc = "Obsidian: Daily work" }
  )
  vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>",
    { desc = "Obsidian: Search notes" }
  )
  vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>",
    { desc = "Obsidian: Switch note" }
  )

  --NOTE: Comment
  vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)",
    { desc = "Comment Line" }
  )
  vim.keymap.set("v", "<leader>c", "<Plug>(comment_toggle_linewise_visual)",
    { desc = "Comment Selected" }
  )
end

--HACK: All those keymaps will be locals for these buffer.
function M.lsp_keymaps(_, bufnr)
  -- La opción `buffer = bufnr` asegura que el atajo solo exista en este buffer.
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- LSP
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

  -- Format and Diagnostic
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
