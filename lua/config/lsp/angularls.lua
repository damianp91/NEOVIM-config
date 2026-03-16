local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config("angularls", {
    cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      vim.fn.stdpath("data") ..
        "/mason/packages/typescript-language-server/node_modules",
      "--ngProbeLocations",
      vim.fn.stdpath("data") ..
        "/mason/packages/angular-language-server/node_modules",
    },

    filetypes = {
      "typescript",
      "html",
      "typescriptreact",
      "typescript.tsx",
    },

    root_markers = {
      "angular.json",
      "project.json",
      "package.json",
      "tsconfig.json",
      ".git",
    },

    capabilities = capabilities,
    on_attach = on_attach,
  })

  vim.lsp.enable("angularls")
end

return M
