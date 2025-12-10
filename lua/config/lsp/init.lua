local cmp_nvim_lsp = require("cmp_nvim_lsp")
local M = {}
M.capabilities = cmp_nvim_lsp.default_capabilities()
vim.lsp.handlers["$/progress"] = function() end

local servers = {
  "lua_ls",
  "pyright",
  "ts_ls",
  "html",
  "cssls",
  "marksman"
}

local on_attach = function(client, bufnr)
  require("config.keymaps").lsp_keymaps(client, bufnr)
end

function M.setup()
  for _, server in ipairs(servers) do
    local ok, server_config = pcall(require, "config.lsp." .. server)
    if ok then
      local setup_ok, setup_err = pcall(server_config.setup, M.capabilities, on_attach)
      if not setup_ok then
        vim.notify(
          "Error loading LSP: " .. server .. "\n" .. tostring(setup_err),
          vim.log.levels.ERROR
        )
      end
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
      cmp.setup()
      -- cmp.setup.buffer({ enabled = true })
    end
    local ok_snip, luasnip = pcall(require, "luasnip")
    if ok_snip then
      luasnip.unlink_current()
    end
  end,
})

return M
