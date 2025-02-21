-- Keymaps for call
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = "Go to declaration"})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Show hover documentation"})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {desc = "Go to implementation"})
vim.keymap.set('n', 'C-k', vim.lsp.buf.signature_help, {desc = "Show function signature help"})
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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Jump to previous diagnostic"})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Jump to next diagnostic"})
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, {desc = "Add diagnostic to the location list"})
-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {desc = "[C]ode [H]over Documentation" })
-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {desc = "[C]ode Goto [D]efinition" })
-- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {desc = "[C]ode [A]ctions" })
-- Set vim motion for <Space> + c + r to display references to the code under the cursor
vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, {desc = "[C]ode Goto [R]eferences" })
-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
vim.keymap.set("n", "<leader>ci",require("telescope.builtin").lsp_implementations,{desc = "[C]ode Goto [I]mplementations" })
-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, {desc = "[C]ode [R]ename" })

