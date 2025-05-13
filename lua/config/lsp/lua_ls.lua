local M = {}

function M.setup()


  require("lspconfig").lua_ls.setup({
    --on_attach = on_attach,
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
