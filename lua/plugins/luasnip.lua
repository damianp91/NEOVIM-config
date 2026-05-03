-- NOTE: Snippets All configuration in config/plugins/luasnip
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "v2.*",
  config = function()
    require("core.plugins.luasnip").setup()
  end
}
