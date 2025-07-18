

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-git",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
    "rafamadriz/friendly-snippets", -- snippets
    "onsails/lspkind.nvim",
    "nvim-treesitter/nvim-treesitter",
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  config = function ()
    require("config.plugins.cmp").setup()
  end,
}

