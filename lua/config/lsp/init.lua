require("config.keymaps")

local M = {}

local servers = {
  "lua_ls",
  "jdtls",
}

function M.setup()
  for _, server in ipairs(servers) do
        local ok, server_config = pcall(require, "config.lsp." .. server)
        if ok then
            server_config.setup()
        else
            vim.notify("Error. server deny connect to LSP: " .. server, vim.log.levels.ERROR)
        end
    end
end

return M
