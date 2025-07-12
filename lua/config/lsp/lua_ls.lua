local M = {}

function M.setup(capabilities)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      }
    }
  })
end

return M
