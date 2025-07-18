
-- All configuration in config/plugins/luasnip
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "v2.*",
  config = function()
    require("config.plugins.luasnip").setup()
  end
}

