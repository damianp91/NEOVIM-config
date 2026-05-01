-- NOTE: Linting detected errors automatly with diagnostics
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    ---@diagnostic disable-next-line: different-requires
    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters.eslint_d.args = {
      "--no-warn-ignored",
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    -- IMPORTANT: Define linters
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      css = {"stylelint"},
      html = {"htmllint"},
      lua = { "luacheck" },
    }

    local timer = nil
    -- Autocommands 
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if timer then
          timer:stop()
        end
        timer = vim.defer_fn(function()
          lint.try_lint()
        end, 200)
      end,
    })

  end,
  -- Diagnostics
  vim.diagnostic.config({
    virtual_text = {
      prefix = " ",
      source = "if_many",
      spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  })
}
