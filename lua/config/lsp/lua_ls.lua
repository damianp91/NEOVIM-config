local M = {}

function M.setup()
  require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      }
    }
  })
end

return M
