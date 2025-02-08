
-- Configs server
return {
  "neovim/nvim-lspconfig",
   dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-jdtls",
    -- Depuration
    "mfussenegger/nvim-dap",                    -- General framework for depuration
    "rcarriga/nvim-dap-ui",                     -- Interfaz at user for nvim-dap
    "theHamsta/nvim-dap-virtual-text",          -- Virtual text for depuration
    "jay-babu/mason-nvim-dap.nvim",             -- Integration of DAP with Mason
    "folke/neodev.nvim",
    "nvim-lua/plenary.nvim",                    -- Library needed for plugins
  },
  config = function()
    -- Global Keymaps 
    require("config.keymaps")
    -- Neodev
    require("neodev").setup()
    -- Configutation lsp separate
    require("config.lsp").setup()
    -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
    vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
    -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
    vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
    -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
    -- Set vim motion for <Space> + c + r to display references to the code under the cursor
    vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
    -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
    vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
    -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
    vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
    -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
    vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
  end
}

