-- NOTE: Mason tool manager for neovim
return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      -- LSP servers
      "angular-language-server",
      "biome",
      "css-lsp",
      "html-lsp",
      "jdtls",
      "lua-language-server",
      "marksman",
      "pyright",
      "slint-lsp",
      "typescript-language-server",
      -- tools
      "google-java-format",
      "java-debug-adapter",
      "java-test"
    },
  },
}
