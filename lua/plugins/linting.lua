-- NOTE: detected errors automatly
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    local eslint = lint.linters.eslint_d

    -- Configuración de eslint_d (como en tu setup original)
    eslint.args = {
      "--no-warn-ignored",
      "--format",
      "json",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.fn.expand("%:p")
      end,
    }

    -- WARN: Not working well for java
    -- lint.linters.checkstyle = {
    --   name = "checkstyle",
    --   cmd = "java",
    --   args = {
    --     "-jar",
    --     " ~/.local/bin/checkstyle.jar",
    --     "-c",
    --     "~/proyectos/config/checkstyle.xml",
    --     "-f",
    --     "json",
    --     vim.fn.expand("%:p"),
    --   },
    --   stdin = false,
    --   parser = require("lint.parser").from_json({
    --     attributes = {
    --       severity = "severity",
    --       message = "message",
    --       lnum = "line",
    --       col = "column",
    --     },
    --   }),
    -- }

    -- NOTE: Define linters
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      -- java = { "checkstyle" },
    }

    -- Autocommands 
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Keymap linting
    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
