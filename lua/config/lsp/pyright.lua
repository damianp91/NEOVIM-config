local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    root_markers = {
      'pyrightconfig.json',
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyproject.toml',
      '.git'
    },
    filetypes = { 'python' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
        },
      },
    },
  })

  vim.lsp.enable('pyright')
end

return M
