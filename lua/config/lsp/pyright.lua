local M = {}

function M.setup(capabilities)
  require('lspconfig').pyright.setup({
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          typeCheckingMode = "basic",
        },
      },
    },
  })
end

return M
