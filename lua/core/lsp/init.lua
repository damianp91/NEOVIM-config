-- NOTE: This is config to 0.12
--
-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- local M = {}

-- M.capabilities = cmp_nvim_lsp.default_capabilities()
-- vim.lsp.handlers["$/progress"] = function() end

-- local on_attach = function(client, bufnr)
--   if client.name == "ts_ls" then
--     client.server_capabilities.documentFormattingProvider = false
--   end
--   require("core.keymaps").lsp_keymaps(client, bufnr)
-- end

-- function M.setup()
--   local servers = require("core.lsp.servers")

--   for name, config in pairs(servers) do
--     local final_config = vim.tbl_deep_extend("force", {
--       capabilities = M.capabilities,
--       on_attach = on_attach,
--     }, config)

--     vim.lsp.config(name, final_config)
--     vim.lsp.enable(name)
--   end
-- end

-- return M

-- NOTE: this is config 0.11+
local M = {}
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local base_capabilities = cmp_nvim_lsp.default_capabilities()
vim.lsp.handlers["$/progress"] = function() end

vim.lsp.config('*', {
  capabilities = base_capabilities,
  root_markers = { '.git' },
})

local servers = require("core.lsp.servers")
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    if not client then return end

    if client.name == "ts_ls" then
      client.server_capabilities.documentFormattingProvider = false
    end

    require("core.keymaps").lsp_keymaps(client, bufnr)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end
  end,
})

function M.setup()
  for name, _ in pairs(servers) do
    vim.lsp.enable(name)
  end
end

return M
