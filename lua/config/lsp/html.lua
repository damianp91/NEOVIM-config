local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config('html', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    root_markers = {
      'package.json',
      '.git'
    },
    filetypes = { 'html', 'templ' },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      configurationSection = { 'html', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = true,
    },
  })

  vim.lsp.enable('html')
end

return M
