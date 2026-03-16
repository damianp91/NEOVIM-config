local lint = require("lint")

lint.linters_by_ft = {
  javascript = {'eslint_d'},
  typescript = {'eslint_d'},
  javascriptreact = {'eslint'},
  typescriptreact = {'eslint'},
  python = {'pylint'},
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    lint.try_lint()
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
  callback = function()
    lint.try_lint()
  end,
})
