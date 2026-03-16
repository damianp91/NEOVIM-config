local M = {}

function M.setup(capabilities, on_attach)
  local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

  local ts_server_path = mason_path .. "/typescript-language-server/node_modules/typescript/lib"
  local ng_server_path = mason_path .. "/angular-language-server/node_modules/@angular/language-server"

  vim.lsp.config("angularls", {
    cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations", ts_server_path,
      "--ngProbeLocations", ng_server_path,
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
