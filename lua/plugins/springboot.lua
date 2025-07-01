return {
  "elmcgill/springboot-nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls"
  },
  ft = "java",
  config = function()
    -- gain acces to the springboot nvim plugin and its functions
    local springboot_nvim = require("springboot-nvim")

    -- set a vim motion to <Space> + <Shift>s + r to run the spring boot project in a vim terminal
    vim.keymap.set('n', '<leader>sr', springboot_nvim.boot_run, {desc = "Springboot: Java Run"})
    -- set a vim motion to <Space> + <Shift>s + c to open the generate class ui to create a class
    vim.keymap.set('n', '<leader>sc', springboot_nvim.generate_class, {desc = "Springboot: Java Create Class"})
    -- set a vim motion to <Space> + <Shift>s + i to open the generate interface ui to create an interface
    vim.keymap.set('n', '<leader>si', springboot_nvim.generate_interface, {desc = "Springboot: Java Create Interface"})
    -- set a vim motion to <Space> + <Shift>s + e to open the generate enum ui to create an enum
    vim.keymap.set('n', '<leader>se', springboot_nvim.generate_enum, {desc = "Springboot: Java Create Enum"})
    -- Run with Springboot
    -- vim.keymap.set('n', '<leader>sr', function()
    --   local gradle_file = vim.fn.findfile('build.gradle', '.;')
    --   local maven_file = vim.fn.findfile('pom.xml', '.;')
    --   local cmd
    --   if gradle_file ~= '' then
    --     cmd = './gradlew bootRun'
    --   elseif maven_file ~= '' then
    --     cmd = './mvnw spring-boot:run'
    --   else
    --     print("Not found configuration for Gradle or Maven.")
    --     return
    --   end
    --   require('toggleterm.terminal').Terminal:new({
    --     cmd = cmd,
    --     direction = "horizontal",
    --     close_on_exit = false,
    --     hidden = true,
    --   }):toggle()
    -- end, { desc = "Springboot: Run code" })

    -- run the setup function with default configuration
    springboot_nvim.setup()
  end
}
