return {
  -- cmd = { "marksman", "server" },
  cmd = {
    "steam-run",
    vim.fn.stdpath("data") .. "/mason/bin/marksman",
    "server",
  },
  filetypes = { "markdown" },
  single_file_support = true,
}
