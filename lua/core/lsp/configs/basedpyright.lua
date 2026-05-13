return {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "standard",

        inlayHints = {
          callArgumentNames = true,
        },

        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
