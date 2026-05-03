local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

local ts_server_path = mason_path .. "/typescript-language-server/node_modules/typescript/lib"
local ng_server_path = mason_path .. "/angular-language-server/node_modules/@angular/language-server"

return {
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations", ts_server_path,
    "--ngProbeLocations", ng_server_path,
  },
  filetypes = {
    "typescript",
    "html",
    "typescriptreact",
  },
  root_markers = {
    "angular.json",
    "project.json",
    "package.json",
    "tsconfig.json",
    ".git",
  },
}
