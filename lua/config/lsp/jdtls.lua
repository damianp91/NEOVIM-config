-- Java (jdtls)
local mason_registry = require("mason-registry")
-- Paths for config jdtls
local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
local jdtls_jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
local jdtls_config = jdtls_path .. "/config_linux"
local lombok_path = jdtls_path .. "/lombok.jar"
-- Function for customise bundles
local function get_bundles()
  -- Get the Mason Registry to gain access to downloaded binaries
  local mason_regis = require("mason-registry")
  local java_debug_adapter_path = mason_regis.get_package("java-debug-adapter")
  -- Obtain the full path to the directory where Mason has downloaded the Java Debug Adapter binaries
  local java_debug_path = java_debug_adapter_path:get_install_path()
  local bundles = {
    vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar")
  }
  -- Find the Java Test package in the Mason Registry
  local java_test = mason_regis.get_package("java-test")
  -- Obtain the full path to the directory where Mason has downloaded the Java Test binaries
  local java_test_path = java_test:get_install_path()
  -- Add all of the Jars for running tests in debug mode to the bundles list
  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
  return bundles
end
-- Detected root file
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "settings.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace") .. "/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
-- Function for all keymap of the jdtls
local function java_keymaps()
  -- Run JdtCompile as a Vim command
  vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
  -- Run JdtUpdateConfig as a Vim command
  vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  -- Run JdtBytecode as a Vim command
  vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  -- Run JdtShell as a Vim command
  vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
  -- Run code single
  vim.keymap.set('n', '<leader>r', function()
    local project_root = vim.fn.getcwd()
    local java_files = vim.fn.systemlist(string.format('find %s/src/main/java -name "*.java"', project_root))
    local files = table.concat(java_files, " ")
    local cmd = string.format('javac -d %s/bin %s && java -cp %s/bin com.damianp.pruebaMaven.App',project_root, files, project_root)
    require('toggleterm.terminal').Terminal:new({
      cmd = cmd,
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
    }):toggle()
  end, { desc = "Compile and execute all project java Maven" })
  -- Run with Springboot
  vim.keymap.set('n', '<leader>sr', function()
    local gradle_file = vim.fn.findfile('build.gradle', '.;')
    local maven_file = vim.fn.findfile('pom.xml', '.;')
    local cmd
    if gradle_file ~= '' then
      cmd = './gradlew bootRun'
    elseif maven_file ~= '' then
      cmd = './mvnw spring-boot:run'
    else
      print("No se encontró configuración para Gradle o Maven.")
      return
    end
    require('toggleterm.terminal').Terminal:new({
      cmd = cmd,
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
    }):toggle()
  end, { desc = "Run code Spring Boot" })
  -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
  vim.keymap.set('n', '<leader>jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "[J]ava [O]rganize Imports" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
  vim.keymap.set('n', '<leader>jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "[J]ava Extract [V]ariable" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
  vim.keymap.set('v', '<leader>jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "[J]ava Extract [V]ariable" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
  vim.keymap.set('n', '<leader>jC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "[J]ava Extract [C]onstant" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
  vim.keymap.set('v', '<leader>jC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "[J]ava Extract [C]onstant" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
  vim.keymap.set('n', '<leader>jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "[J]ava [T]est Method" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
  vim.keymap.set('v', '<leader>jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "[J]ava [T]est Method" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
  vim.keymap.set('n', '<leader>jT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
  -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
  vim.keymap.set('n', '<leader>ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local on_attach = function()
  -- Map the Java specific key mappings once the server is attached
  java_keymaps()
  -- Setup the java debug adapter of the JDTLS server
  require('jdtls.dap').setup_dap()
  -- Find the main method(s) of the application so the debug adapter can successfully start up the application
  require('jdtls.dap').setup_dap_main_class_configs()
  -- Refresh the codelens
  vim.lsp.codelens.refresh()
  -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.java" },
    callback = function()
      local _, _ = pcall(vim.lsp.codelens.refresh)
    end
  })
end

local M = {}

function M.setup()
  local jdtls = require "jdtls"
  local capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        snippetSupport = false
      }
    },
  }
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- Get the default extended client capablities of the JDTLS language server
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  for k,v in pairs(lsp_capabilities) do capabilities[k] = v end
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
      '-javaagent:' .. lombok_path,
      "-jar",
      vim.fn.glob(jdtls_jar),
      "-configuration",
      jdtls_config,
      "-data",
      workspace_dir,
    },
    root_dir = root_dir,
    -- Function that will be ran once the language server is attached
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      java = {
        -- Enable code formatting
        format = {
          enabled = true,
          -- Use the Google Style guide for code formattingh
          settings = {
            url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
            profile = "GoogleStyle"
          }
        },
        eclipse = {
          downloadSource = true
        },
        maven = {
          downloadSources = true
        },
        signatureHelp = {
          enabled = true
        },
        contentProvider = {
          preferred = "fernflower"
        },
        sources = {
          -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
          organizeImports = {
            starThreshold = 9999,
            staticThreshold = 9999
          }
        },
        completion = {
          -- When using an unimported static method, how should the LSP rank possible places to import the static method from
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          -- Try not to suggest imports from these packages in the code action window
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
          -- Set the order in which the language server should organize imports
          importOrder = {
            "java",
            "jakarta",
            "javax",
            "com",
            "org",
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          },
          hashCodeEquals = {
            useJava7Objects = true
          },
          -- When generating code use code blocks
          useBlocks = true
        },
        configuration = {
          updateBuildConfiguration = "interactive"
        },
        -- enable code lens in the lsp
        referencesCodeLens = {
          enabled = true
        },
        inlayHints = {
          parameterNames = {
            enabled = "all"
          }
        }
      },
    },
    init_options = {
      bundles = get_bundles(),
      extendedClientCapabilities = extendedClientCapabilities
    },
  })
end
return M
