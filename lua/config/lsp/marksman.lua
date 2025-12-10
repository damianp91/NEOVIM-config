local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config('marksman', {
    cmd = {"marksman", "server"},
    filetypes = {"markdown"},
    single_file_support = true,
    capabilities = capabilities,
    on_attach = on_attach,
  })
  vim.lsp.enable('marksman')
end

return M
