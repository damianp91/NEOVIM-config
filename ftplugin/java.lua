-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- Based on official JDTLS launch configuration:
-- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line

-- Java (jdtls)
local jdtls = require('jdtls')

-- Necesary paths
local home = os.getenv("HOME")
local jdtls_dir = home .. "/.local/share/nvim/mason/packages/jdtls"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins"

-- Detected JAR launcher version
local launcher_jar = vim.fn.glob(plugins_dir .. "/org.eclipse.equinox.launcher_*.jar")
if launcher_jar == "" then
  vim.notify("JDTLS launcher jar not found.", vim.log.levels.ERROR)
  return
end

-- Detect root_dir
local root_dir = vim.fs.root(0, {
  ".git", "mvnw", "gradlew", "pom.xml", "settings.gradle", "build.xml", ".project",".classpath"
})
if not root_dir then
  vim.notify("Don't detected root_dir para jdtls", vim.log.levels.WARN)
  return
end

-- Generate path workspace unique for project
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name

-- To get bundles for debuging and test
local function get_bundles()
  local bundles = {}
  vim.list_extend(bundles, vim.split(vim.fn.glob(
    home .. ".local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ), "\n"))

  vim.list_extend(bundles, vim.split(vim.fn.glob(
    home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"
  ), "\n"))

  return bundles
end

-- To get capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
    -- Detect class with method `main`
    local main_class = ""
    for _, file in ipairs(java_files) do
      local content = table.concat(vim.fn.readfile(file), "\n")
      if content:match("public%s+static%s+void%s+main%s*%(") then
        main_class = file:match("src/main/java/(.+)%.java$")
        main_class = main_class:gsub("/", ".")
        break
      end
    end
    if main_class == "" then
      vim.notify("Not found any class with method main.", vim.log.levels.ERROR)
      return
    end
    local cmd = string.format('javac -d %s/bin %s && java -cp %s/bin %s', project_root, files, project_root, main_class)
    require('toggleterm.terminal').Terminal:new({
      cmd = cmd,
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
    }):toggle()
  end, { desc = "Java: Compile and execute all project java" })
  -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
  vim.keymap.set('n', '<leader>jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "Java: Organize Imports" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
  vim.keymap.set('n', '<leader>jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "Java: Extract Variable" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
  vim.keymap.set('v', '<leader>jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "Java: Extract Variable" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
  vim.keymap.set('n', '<leader>jC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "Java: Extract Constant" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
  vim.keymap.set('v', '<leader>jC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "Java: Extract Constant" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
  vim.keymap.set('n', '<leader>jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "Java: Test Method" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
  vim.keymap.set('v', '<leader>jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "Java: Test Method" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
  vim.keymap.set('n', '<leader>jT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "Java: Test Class" })
  -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
  vim.keymap.set('n', '<leader>ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "Java: Update Config" })
end

-- Configuration
local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1G",
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = root_dir,
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
        -- How many classes from a specific package should be imported before automatic
        -- imports combine them all into a single import
        organizeImports = {
          starThreshold = 9999,
          staticThreshold = 9999
        }
      },
      completion = {
        -- When using an unimported static method, how should the LSP rank possible
        -- places to import the static method from
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
    }
  },
  init_options = {
    bundles = get_bundles(),
  },
  on_attach = function()
    vim.lsp.codelens.refresh()
    java_keymaps()
  end,
  capabilities = capabilities,
}

jdtls.start_or_attach(config)

