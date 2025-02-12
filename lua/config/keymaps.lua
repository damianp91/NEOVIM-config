local M = {}

-- Keymaps for call
function M.setup(bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  --local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer = bufnr, desc = "Go to declaration"})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr, desc = "Show hover documentation"})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer = bufnr, desc = "Go to implementation"})
  vim.keymap.set('n', 'C-k', vim.lsp.buf.signature_help, {buffer = bufnr, desc = "Show function signature help"})
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {buffer = bufnr, desc = "Add workspace folder"})
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {buffer = bufnr, desc = "Remove workspace folder"})
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {buffer = bufnr, desc = "List workspace folders"})
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer = bufnr, desc = "Show type definition"})
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, {buffer = bufnr, desc = "Format code"})
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {buffer = bufnr, desc = "Show floating diagnostics"})
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer = bufnr, desc = "Jump to previous diagnostic"})
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer = bufnr, desc = "Jump to next diagnostic"})
  vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, {buffer = bufnr, desc = "Add diagnostic to the location list"})
  -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
  vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {buffer = bufnr, desc = "[C]ode [H]over Documentation" })
  -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
  vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {buffer = bufnr, desc = "[C]ode Goto [D]efinition" })
  -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {buffer = bufnr, desc = "[C]ode [A]ctions" })
  -- Set vim motion for <Space> + c + r to display references to the code under the cursor
  vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, {buffer = bufnr, desc = "[C]ode Goto [R]eferences" })
  -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
  vim.keymap.set("n", "<leader>ci", function()
    vim.lsp.buf.implementation()
  end,{buffer = bufnr, desc = "[C]ode Goto [I]mplementations" })
  -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
  vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, {buffer = bufnr, desc = "[C]ode [R]ename" })
  -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
  vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, {buffer = bufnr, desc = "[C]ode Goto [D]eclaration" })
end

return M
