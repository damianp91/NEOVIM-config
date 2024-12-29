
local M = {}

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

  print("Proyecto Java creado en: " .. project_path)
end, { desc = "Create a new project of Java and open" })

-- Keymaps for call
function M.setup(bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'C-k', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Java-specific keymaps
  -- Imports organize
  vim.keymap.set('n', '<leader>oi', function()
    vim.lsp.buf.execute_command({ command = "java.sources.organizeImports" })
  end, opts)

  -- Run code
  vim.keymap.set('n', '<leader>r', function()
    local file = vim.fn.expand('%:p') -- Ruta completa del archivo actual
    local classname = vim.fn.expand('%:t:r') -- Nombre de la clase actual
    local package_path = vim.fn.expand('%:.:h'):gsub("/", "."):gsub("^src%.main%.java%.", "")

    local cmd = string.format('javac -d bin %s && java -cp bin %s.%s', file, package_path, classname)
    vim.cmd('split | term ' .. cmd)
    vim.cmd('startinsert')
  end, opts)

  -- Tests
  vim.keymap.set('n', '<leader>tu', function()
    vim.cmd('JdtRunTest') -- Requiere integración con nvim-jdtls
  end, opts)

  -- Depuration with nvim-dap
  vim.keymap.set('n', '<F5>', function()
    require('dap').continue()
  end, opts)
  vim.keymap.set('n', '<F10>', function()
    require('dap').step_over()
  end, opts)
  vim.keymap.set('n', '<F11>', function()
    require('dap').step_into()
  end, opts)
  vim.keymap.set('n', '<F12>', function()
    require('dap').step_out()
  end, opts)

end

return M









