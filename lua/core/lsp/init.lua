local cmp_nvim_lsp = require("cmp_nvim_lsp")
local M = {}

M.capabilities = cmp_nvim_lsp.default_capabilities()
vim.lsp.handlers["$/progress"] = function() end

local on_attach = function(client, bufnr)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  require("core.keymaps").lsp_keymaps(client, bufnr)
end

function M.setup()
  local servers = require("core.lsp.servers")

  for name, config in pairs(servers) do
    local final_config = vim.tbl_deep_extend("force", {
      capabilities = M.capabilities,
      on_attach = on_attach,
    }, config)

    vim.lsp.config(name, final_config)
    vim.lsp.enable(name)
  end
end

return M
