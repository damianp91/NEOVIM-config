local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    root_markers = {
      'tsconfig.json',
      'jsconfig.json',
      'package.json',
      '.git'
    },
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx'
    },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      preferences = {
        disableSuggestions = false,
      },
    },
  })

  vim.lsp.enable('ts_ls')
end

return M

