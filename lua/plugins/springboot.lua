return {
  "elmcgill/springboot-nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls"
  },
  ft = "java",
  config = function()
    -- gain acces to the springboot nvim plugin and its functions
    local springboot_nvim = require("springboot-nvim")
    springboot_nvim.setup()
  end
}
