-- General Settings
vim.opt.number = true              -- Show number of every line command
vim.opt.relativenumber = true      -- Show relative number of actual line
vim.opt.tabstop = 2                -- Set the number of spaces for each tabstop
vim.opt.shiftwidth = 2             -- Set the number of spaces for each indent
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true    -- Colors in terminal
vim.opt.scrolloff = 8           -- 8 lines for each scroll
vim.opt.sidescrolloff = 8       -- 8 columns for lateral scroll
vim.opt.wrap = true            -- Desactiva el ajuste de línea (líneas largas no se ajustan)
vim.opt.cursorline = true       -- Highlight actual line
vim.opt.showmatch = true
vim.opt.updatetime = 300       -- Tiempo de espera para eventos (reducción de latencia)

-- General mapping 
vim.g.mapleader = " "          -- leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })

-- Keymaps Alpha
vim.keymap.set('n', '<leader>in', function()
  vim.cmd('Alpha')
end, {desc = 'Return to the beginning'})

-- Keymaps tree
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd('NvimTreeOpen')
end, {desc = 'Open Nvim tree'})
vim.keymap.set('n', '<leader>ct', function()
  vim.cmd('NvimTreeClose')
end, {desc = 'Close nvim tree'})

-- Keymaps treminal
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {desc = 'Escape terminal'})
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], {desc = "Move left"})
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], {desc = "Move down"})
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], {desc = "Move up"})
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], {desc = "Move right"})

-- Keymaps for buffers
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', {desc = "Window vertical buffer"})
vim.keymap.set('n', '<leader>wh', ':split<cr>', {desc = "Window horizontal buffer"})

-- To make a new project Java with Gradle
-- Keymap for create java proyect
vim.keymap.set('n', '<leader>nj', function()
  local project_name = vim.fn.input("Name of project: ")
  if project_name == "" then
    print("Error: You must provide a name for the proyect.")
    return
  end
  local project_path = vim.fn.expand("~/NvimProjectsJava/") .. project_name
  local main_class = "Main"
  local package_name = "com.damianp." .. project_name
  vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")     -- Create directories
  vim.fn.mkdir(project_path .. "/src/test/java", "p")
  -- Create file build.gradle
  local build_gradle = [[
plugins {
  id 'application'
  id 'java'
}
group = ']] .. package_name .. [['
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
    print("Created build.gradle")
  else
    print("Error: Could not create build.gradle")
  end
  -- Create file settings.gradle
  local settings_gradle = "rootProject.name = '" .. project_name .. "'"
  local settings_gradle_path = project_path .. "/settings.gradle"
  local settings_gradle_file = io.open(settings_gradle_path, "w")
  if settings_gradle_file then
    settings_gradle_file:write(settings_gradle)
    settings_gradle_file:close()
    print("Created settings.gradle")
  else
    print("Error: Could not create settings.gradle")
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
  local main_java_file = io.open(main_java_path, "w")
  if main_java_file then
    main_java_file:write(main_java)
    main_java_file:close()
    print("Created Main.java")
  else
    print("Error: Could not be creates file Main.java")
  end
  vim.cmd("edit " .. main_java_path)     -- Open file Main.java in Neovim
  vim.cmd("cd " .. project_path)         -- move to directorie project
  print("Created project in: " .. project_path)
end, { desc = "Create a new project of Java and open it" })

