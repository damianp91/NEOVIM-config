local cmp_nvim_lsp = require("cmp_nvim_lsp")
local M = {}
M.capabilities = cmp_nvim_lsp.default_capabilities()
vim.lsp.handlers["$/progress"] = function() end

local on_attach = function(client, bufnr)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  require("config.keymaps").lsp_keymaps(client, bufnr)
end

function M.setup()
  local lsp_path = vim.fn.stdpath("config") .. "/lua/config/lsp"
  local files = vim.fn.readdir(lsp_path)

  for _, file in ipairs(files) do
    if file ~= "init.lua" and file:match("%.lua$") then
      local server = file:gsub("%.lua$", "")

      local ok, server_config = pcall(require, "config.lsp." .. server)

      if ok then
        local setup_ok, setup_err =
          pcall(server_config.setup, M.capabilities, on_attach)

        if not setup_ok then
          vim.notify(
            "Error loading LSP: " .. server .. "\n" .. tostring(setup_err),
            vim.log.levels.ERROR
          )
        end
      else
        vim.notify(
          "Failed to load LSP config: " .. server,
          vim.log.levels.ERROR
        )
      end
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
