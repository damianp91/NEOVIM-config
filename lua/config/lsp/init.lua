local keymaps = require("config.keymaps")

local M = {}

local servers = {
  "lua_ls",
  "jdtls",
}

local function on_attach(_, bufnr)
  keymaps.setup(bufnr)
end

function M.setup()
  for _, server in ipairs(servers) do
        local ok, server_config = pcall(require, "config.lsp." .. server)
        if ok then
            server_config.setup({on_attach = on_attach})
        else
            vim.notify("Error. server deny connect to LSP: " .. server, vim.log.levels.ERROR)
        end
    end
end

return M
