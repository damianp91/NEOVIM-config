local M = {}

function M.setup()
  --NOTE: General (Vim)
  vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Vim: Save file' })
  vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Vim: Close window' })
  vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = "Vim: Reload current file" })

  --NOTE: Buffer Navigation
  vim.keymap.set("n", "<S-l>", ":bnext<CR>", {desc = "Buffer: Next buffer", silent = true})
  vim.keymap.set("n", "<S-h>", ":bprev<CR>",
    { desc = "Buffer: Previous buffer", silent = true }
  )
  vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers,
    { desc = "Buffer: Find buffer" }
  )
  vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>",
    { desc = "Buffer: Close other buffers" }
  )

  --NOTE: Windows
  vim.keymap.set('n', '<leader>wv', ':vsplit<cr>',
    { desc = "Window: Vertical split" }
  )
  vim.keymap.set('n', '<leader>wH', ':split<cr>',
    { desc = "Window: Horizontal split" }
  )
  vim.keymap.set('n', '<leader>wh', [[<Cmd>wincmd h<CR>]],
    { desc = "Window: Move left" }
  )
  vim.keymap.set('n', '<leader>wj', [[<Cmd>wincmd j<CR>]],
    { desc = "Window: Move down" }
  )
  vim.keymap.set('n', '<leader>wk', [[<Cmd>wincmd k<CR>]],
    { desc = "Window: Move up" }
  )
  vim.keymap.set('n', '<leader>wl', [[<Cmd>wincmd l<CR>]],
    { desc = "Window: Move right" }
  )

  --NOTE: Git
  vim.keymap.set({'n', 'v'}, '<leader>gg',
    function() require('snacks').lazygit.open() end,
    { desc = "Git: LazyGit open"}
  )

  --NOTE: UI
  vim.keymap.set('n', '<leader>uo', function()
    require("opencode").toggle()
  end, { desc = "UI: OpenCode toggle panel" })

  vim.keymap.set({'n', 'x'}, '<leader>ua', function()
    require("opencode").select()
  end, { desc = "UI: OpenCode select action" })

  vim.keymap.set({'n', 'x'}, '<leader>ue', function()
    require("opencode").prompt("explain")
  end, { desc = "UI: OpenCode explain code" })

  vim.keymap.set('n', '<leader>ui', function() require("snacks").dashboard.open() end,
    { desc = 'UI: Open dashboard' }
  )

  vim.keymap.set("n", "<leader>uT", vim.cmd.UndotreeToggle,
    { desc = "UI: Toggle UndoTree" }
  )

  vim.keymap.set('n', "<leader>ur", function() require("which-key").setup() end,
    { desc = "UI: Reload WhichKey" }
  )

  --NOTE: Explorer
  vim.keymap.set('n', '<leader>ee', ':Oil<cr>', { desc = "Explorer: Open Oil" })
  vim.keymap.set('n', '<leader>ef', require("oil").toggle_float,
    { desc = "Explorer: Oil float" }
  )

  --NOTE: Terminal
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],
    { desc = "Terminal: Escape terminal" }
  )
  vim.keymap.set('n', '<leader>th',
    function() vim.cmd("ToggleTerm direction=horizontal") end,
    { desc = "Terminal: Horizontal" }
  )
  vim.keymap.set('n', '<leader>tv',
    function() vim.cmd("ToggleTerm direction=vertical") end,
    { desc = "Terminal: Vertical" }
  )
  vim.keymap.set('n', '<leader>tf',
    function() vim.cmd("ToggleTerm direction=float") end,
    { desc = "Terminal: Float" }
  )

  --NOTE: Picker
  vim.keymap.set('n', "<leader>pf", function() require("snacks").picker.files() end,
    { desc = "Picker: Find Files" }
  )
  vim.keymap.set('n', "<leader>pc",
    function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Picker: Find Config File" }
  )
  vim.keymap.set('n', "<leader>pg", function() require("snacks").picker.grep() end,
    { desc = "Picker: Grep word" }
  )
  vim.keymap.set({'n', 'x'}, "<leader>ps",
    function() require("snacks").picker.grep_word() end,
    { desc = "Picker: Search visual selection" }
  )
  vim.keymap.set('n', "<leader>pk",
    function() require("snacks").picker.keymaps({ layout = "telescope" }) end,
    { desc = "Picker: Search keymaps" }
  )

  --NOTE: Notes (Obsidian)
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
  vim.keymap.set("n", "<leader>nws", ":ObsidianWorkspace<CR>",
    { desc = "Notes: Switch workspace" }
  )
  vim.keymap.set("n", "<leader>nap", ":ObsidianOpen<CR>",
    { desc = "Notes: Open in Obsidian app" }
  )
  vim.keymap.set("n", "<leader>nn",
    create_note(vim.fn.expand("~/vaults/personal/notes/"), "Quick personal note: "),
    { desc = "Notes: New personal note" }
  )
  vim.keymap.set("n", "<leader>nns",
    create_note(vim.fn.expand("~/vaults/personal/second-brain/"),
      "Brain (ej: languages/java): "
    ),
    { desc = "Notes: New note to second-brain" }
  )
  vim.keymap.set("n", "<leader>nnw",
    create_note(vim.fn.expand("~/vaults/work/notes/"), "Work (ej: tasks/bug-123): "),
    { desc = "Notes: New work note" }
  )
  vim.keymap.set("n", "<leader>ndp",
    function()
      vim.cmd("ObsidianWorkspace personal")
      vim.defer_fn(function()
        vim.cmd("ObsidianToday")
      end, 100)
    end, { desc = "Notes: Daily personal" }
  )
  vim.keymap.set("n", "<leader>ndw",
    function()
      vim.cmd("ObsidianWorkspace work")
      vim.defer_fn(function()
        vim.cmd("ObsidianToday")
      end, 100)
    end, { desc = "Notes: Daily work" }
  )
  vim.keymap.set("n", "<leader>nsn", ":ObsidianSearch<CR>",
    { desc = "Notes: Search notes" }
  )
  vim.keymap.set("n", "<leader>nsN", ":ObsidianQuickSwitch<CR>",
    { desc = "Notes: Switch note" }
  )

  --NOTE: Notes (Todo Comments)
  vim.keymap.set("n", "<leader>nt", function()
    require("todo-comments").jump_next()
  end, { desc = "Notes: Jump next todo" })

  vim.keymap.set("n", "<leader>np", function()
    require("todo-comments").jump_prev()
  end, { desc = "Notes: Jump prev todo" })

  vim.keymap.set("n", "<leader>na", "<cmd>TodoTelescope<cr>",
    { desc = "Notes: All todos" }
  )
end

function M.lsp_keymaps(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- LSP
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Code Action' })
  )
  vim.keymap.set('n', 'K', vim.lsp.buf.hover,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Hover Documentation'})
  )
  vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Go to Definition'})
  )
  vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Go to Declaration'})
  )
  vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Go to Implementation'})
  )
  vim.keymap.set('n', '<leader>cdf', vim.lsp.buf.type_definition,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Go to Type Definition'})
  )
  vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Find References'})
  )
  vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Rename Symbol'})
  )

  -- Workspace
  vim.keymap.set('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Add Workspace Folder'})
  )
  vim.keymap.set('n', '<leader>cwr', vim.lsp.buf.remove_workspace_folder,
    vim.tbl_extend('force', opts, { desc = 'Code: LSP Remove Workspace Folder'})
  )
  vim.keymap.set('n', '<leader>cwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend('force', opts, { desc = 'Code: LSP List Workspace Folders'}))

  -- Code Actions
  vim.keymap.set('n', '<leader>cf',
    function() vim.lsp.buf.format { async = true } end,
    vim.tbl_extend('force', opts, { desc = 'Code: Format Code'})
  )

  --Diagnostics
  vim.keymap.set('n', '<leader>cdh', vim.diagnostic.open_float,
    vim.tbl_extend('force', opts, { desc = 'Code: Diagnostic show hover'})
  )
  vim.keymap.set('n', '<leader>cpd', function() vim.diagnostic.goto(true) end,
    vim.tbl_extend('force', opts, { desc = 'Code: Diagnostic previous'})
  )
  vim.keymap.set('n', '<leader>cnd', function() vim.diagnostic.goto(false) end,
    vim.tbl_extend('force', opts, { desc = 'Code: Diagnostic next'})
  )
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = 'Code: Diagnostic location list'})
  )
  vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist,
    vim.tbl_extend('force', opts, { desc = 'Code: Diagnostic quickfix list'})
  )
end

return M
