local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config('cssls', {
    cmd = { 'vscode-css-language-server', '--stdio' },
    root_markers = {
      'package.json',
      '.git'
    },
    filetypes = {
      'css',
      'scss',
      'less'
    },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      css = {
        validate = true,
      },
      scss = {
        validate = true,
      },
      less = {
        validate = true,
      },
    },
  })

  vim.lsp.enable('cssls')
end

return M
