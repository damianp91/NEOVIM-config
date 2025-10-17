
return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function ()
    ---@diagnostic disable-next-line: different-requires
    require "config.lint"
  end
}
