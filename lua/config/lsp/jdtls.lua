-- Java (jdtls)
-- Import modules
-- local lspconfig = require('lspconfig')
local lspconfig = require('lspconfig')
local mason_registry = require("mason-registry")
local jdtls_path = "/home/damianp/.local/share/nvim/mason/packages/jdtls"
local workspace_dir = "/home/damianp/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local lombok_path = jdtls_path .. "/lombok.jar"
local debug_adapter_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
local bundles = {
  debug_adapter_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
}
local function java_keymaps(bufnr)
  local opts = { buffer = bufnr, desc = "Java specific keymap" }
  -- Run JdtCompile as a Vim command
  --vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
  -- Run JdtUpdateConfig as a Vim command
  --vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  -- Run JdtBytecode as a Vim command
  --vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  -- Run JdtShell as a Vim command
  --vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
  -- To make a new project Java with Gradle
  vim.keymap.set('n', '<leader>nj', function()
    local project_name = vim.fn.input("Name of project: ")
    if project_name == "" then
      print("Error: You must provide a name for the proyect.")
      return
    end
    local project_path = vim.fn.expand("~/NvimProjectsJava/") .. project_name
    local main_class = "Main"
    local package_name = "com.damianp." .. project_name:gsub(" ", "_")
    -- Create directories
    vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")
    vim.fn.mkdir(project_path .. "/src/test/java", "p")
    -- Create file build.gradle
    local build_gradle = [[
plugins {
  id 'application'
  id 'java'
}
group = 'com.example'
version = '1.0-SNAPSHOT'
repositories {
  mavenCentral()
}
dependencies {
  testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
}
application {
  mainClass = ']] .. package_name .. "." .. main_class .. [['
}
test {
  useJUnitPlatform()
}
]]
    local build_gradle_path = project_path .. "/build.gradle"
    local build_gradle_file = io.open(build_gradle_path, "w")
    if build_gradle_file then
      build_gradle_file:write(build_gradle)
      build_gradle_file:close()
    end
    -- Create file settings.gradle
    local settings_gradle = "rootProject.name = '" .. project_name .. "'"
    local settings_gradle_path = project_path .. "/settings.gradle"
    local settings_gradle_file = io.open(settings_gradle_path, "w")
    if settings_gradle_file then
      settings_gradle_file:write(settings_gradle)
      settings_gradle_file:close()
    end
    -- Create file Main.java
    local main_java = [[
package ]] .. package_name .. [[;

public class Main {
  public static void main(String[] args) {
    System.out.println("¡Hello world from the project ]] .. project_name .. [[!");
  }
}
]]
    local main_java_path = project_path .. "/src/main/java/" .. package_name:gsub("%.", "/") .. "/Main.java"
    vim.fn.mkdir(vim.fn.fnamemodify(main_java_path, ":h"), "p")
    local main_java_file = io.open(main_java_path, "w")
    if main_java_file then
      main_java_file:write(main_java)
      main_java_file:close()
    else
      print("Error: Could not be creates file Main.java")
    end
    -- Open file Main.java in Neovim
    vim.cmd("edit " .. main_java_path)
    -- move to directorie project
    vim.cmd("cd " .. project_path)
    print("Created project in: " .. project_path)
  end, { desc = "Create a new project of Java and open" })
  -- Run code
  vim.keymap.set('n', '<leader>r', function()
    local file = vim.fn.expand('%:p') -- Ruta completa del archivo actual
    local classname = vim.fn.expand('%:t:r') -- Nombre de la clase actual
    local package_path = vim.fn.expand('%:.:h'):gsub("/", "."):gsub("^src%.main%.java%.", "")
    local cmd = string.format('javac -d bin %s && java -cp bin %s.%s', file, package_path, classname)
    vim.cmd('split | term ' .. cmd)
    vim.cmd('startinsert')
  end, opts)
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

local on_attach = function(_, bufnr)
  -- Map the Java specific key mappings once the server is attached
  java_keymaps(bufnr)
  -- Setup the java debug adapter of the JDTLS server
  require('jdtls.dap').setup_dap()
  -- Find the main method(s) of the application so the debug adapter can successfully start up the application
  -- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
  -- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
  -- Unfortunately I have not found an elegant way to ensure this works 100%
  require('jdtls.dap').setup_dap_main_class_configs()
  -- Refresh the codelens
  -- Code lens enables features such as code reference counts, implemenation counts, and more.
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
      vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      "-configuration",
      jdtls_path .. "/config_linux",
      "-data",
      workspace_dir,
    },
    root_dir = lspconfig.util.root_pattern({".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle"}),
    -- Function that will be ran once the language server is attached
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      java = {
        -- Enable downloading archives from eclipse automatically
        project = {
          referenceLibraries = {
            "lib/*/.jar"
          },
        },
        server = {
          lauchMode = "hybrid",
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
      bundles = bundles,
      extendedClientCapabilities = extendedClientCapabilities
    },
  })
end

return M
