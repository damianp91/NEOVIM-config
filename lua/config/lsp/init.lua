
local M = {}

local servers = {
  "lua_ls",
  "jdtls",
}

function M.setup(on_attach)
  for _, server in ipairs(servers) do
        local ok, server_config = pcall(require, "config.lsp." .. server)
        if ok then
            server_config.setup(on_attach)
        else
            vim.notify("Error. server deny connect " .. server, vim.log.levels.ERROR)
        end
    end
end

return M
