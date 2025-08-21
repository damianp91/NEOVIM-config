local lint = require("lint")

lint.linters_by_ft = {
  javascript = {'eslint'},
  typescript = {'eslint'},
  javascriptreact = {'eslint'},
  typescriptreact = {'eslint'},
  python = {'pylint'},
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    require('lint').try_lint()
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
  callback = function()
    require('lint').try_lint()
  end,
})
