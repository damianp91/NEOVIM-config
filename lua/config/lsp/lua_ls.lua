local M = {}

function M.setup(opts)
  require("lspconfig").lua_ls.setup({
    on_attach = opts.on_attach,
    settings = {
      Lua = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      }
    }
  })
end

return M
