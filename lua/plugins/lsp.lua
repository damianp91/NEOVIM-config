
-- Configs server
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-jdtls",
    -- Depuration
    "mfussenegger/nvim-dap",                    --  General framework for depuration
    "rcarriga/nvim-dap-ui",                     -- Interfaz at user for nvim-dap
    "theHamsta/nvim-dap-virtual-text",          -- Virtual text for depuration
    "jay-babu/mason-nvim-dap.nvim",             -- Integration of DAP with Mason
    "folke/neodev.nvim",
    "nvim-lua/plenary.nvim",                    -- Library needed for plugins
  },
  config = function()
    local keymaps = require("config.keymaps")
    local on_attach = function(_, bufnr)
      keymaps.setup(bufnr)
    end

    -- Neodev
    require("neodev").setup()

    -- Configutation lsp separate
    require("config.lsp").setup(on_attach)
  end
}

