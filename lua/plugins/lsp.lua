
-- Configs server
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-jdtls",
    -- Depuración
    "mfussenegger/nvim-dap", -- Framework general para depuración
    "rcarriga/nvim-dap-ui", -- Interfaz de usuario para nvim-dap
    "theHamsta/nvim-dap-virtual-text", -- Virtual text para depuración
    "jay-babu/mason-nvim-dap.nvim", -- Integración de DAP con Mason
    "folke/neodev.nvim",
    "nvim-lua/plenary.nvim", -- Biblioteca necesaria para varios plugins
  },
  config = function()
    local keymaps = require("config.keymaps")
    local on_attach = function(_, bufnr)
      keymaps.setup(bufnr)
    end

    -- Neodev
    require("neodev").setup()

    -- Lua
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        }
      }
    })

    -- Java (jdtls)
    local lspconfig = require('lspconfig')
    local jdtls_path = "/home/damianp/.local/share/nvim/mason/packages/jdtls"
    local workspace_dir = "/home/damianp/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    require("lspconfig").jdtls.setup({
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-noverify",
        "-Xmx1G",
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        "-jar",
        vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        jdtls_path .. "/config_linux",
        "-data",
        workspace_dir,
      },
      root_dir = lspconfig.util.root_pattern({"git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          sources = {
            organizeImports = true,
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
          },
        },
      },
      init_options = {
        bundles = {
          vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.jdt.ls.adapters.debug_*.jar", true),
        },
      },
      on_attach = on_attach,
    })
  end
}

