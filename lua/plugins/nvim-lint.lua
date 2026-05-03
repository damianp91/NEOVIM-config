-- NOTE: Lint lintters ansyc for errors, warnings... etc
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    ---@diagnostic disable-next-line: different-requires
    require("core.plugins.lint")
  end
}
