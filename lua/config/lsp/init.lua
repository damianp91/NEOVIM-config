require("config.keymaps")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local M = {}

M.capabilities = cmp_nvim_lsp.default_capabilities()


local servers = {
  "lua_ls",
  "pyright",
  "ts_js",
  "html",
  "ccsls"
}

function M.setup()
  for _, server in ipairs(servers) do
    local ok, server_config = pcall(require, "config.lsp." .. server)
    if ok then
      server_config.setup(M.capabilities)
    else
      vim.notify("Error. server deny connect to LSP: " .. server, vim.log.levels.ERROR)
    end
  end
end

-- For restart cmp and snippets
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local ok_cmp, cmp = pcall(require, "cmp")
    if ok_cmp then
      cmp.setup.buffer({ enabled = true })
    end

    local ok_snip, luasnip = pcall(require, "luasnip")
    if ok_snip then
      luasnip.unlink_current()
    end
  end,
})

return M
