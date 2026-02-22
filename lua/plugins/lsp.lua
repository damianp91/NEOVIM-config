
-- Configs server
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    -- Depuration
    "mfussenegger/nvim-dap",                    -- General framework for depuration
    "rcarriga/nvim-dap-ui",                     -- Interfaz at user for nvim-dap
    "theHamsta/nvim-dap-virtual-text",          -- Virtual text for depuration
    "jay-babu/mason-nvim-dap.nvim",             -- Integration of DAP with Mason
    "folke/neodev.nvim",
    "nvim-lua/plenary.nvim",                    -- Library needed for plugins
  },
  config = function()
    -- Neodev
    require("neodev").setup()

    -- Configutation lsp separate
    require("config.lsp").setup()

    -- Keymaps
    require("config.keymaps")

    -- DAP
    require("nvim-dap-virtual-text").setup({})

    local dap = require("dap")
    vim.keymap.set('n', '<F5>', dap.continue, { desc = "DAP: Start/Continue" })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = "DAP: Step Over" })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = "DAP: Step Into" })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = "DAP: Step Out" })
    vim.keymap.set('n', '<Leader>dk', dap.toggle_breakpoint,
      { desc = "DAP: Toggle Breakpoint" }
    )
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "DAP: Open REPL" })
  end
}

