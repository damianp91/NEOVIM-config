-- NOTE: LSP Configs server
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    { "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            avoid = { "NvimTree" },
          },
        },
      } },
    "folke/neodev.nvim",
  },
  config = function()
    -- Neodev
    require("neodev").setup()

    -- Configutation lsp separate
    require("core.lsp.init").setup()
  end
}
