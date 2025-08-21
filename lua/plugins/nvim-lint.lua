
return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function ()
    require "config.lint"
  end
}
