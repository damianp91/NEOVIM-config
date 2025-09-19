local M = {}

function M.setup(capabilities, on_attch)
  require('lspconfig').ts_ls.setup({
    on_attch = on_attch,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true
      }
    },
    settings = {
      typescript = {
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
      javascript = {
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  })
end

return M
