
-- Configs server
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
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

  end
}

