-- NOTE: DAP (Debug Adapter Protocol) for java
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- ui plugins to make debugging simplier
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text"
  },
  cmd = {
    "DapContinue",
    "DapToggleBreakpoint",
    "DapStepInto",
    "DapStepOver"
  },
  config = function()
    require("core.dap").setup()
    -- gain access to the dap plugin and its functions
    --     local dap = require("dap")
    --     local dapui = require("dapui")
    --     local dapvirt = require("nvim-dap-virtual-text")

    --     dapui.setup()

    --     dapvirt.setup({
    --       enable = true,
    --       virtual_text = {
    --         prefix = " ●",
    --       },
    --     })

    --     -- gain access to the dap ui plugin and its functions
    --     dap.listeners.before.attach.dapui_config = function()
    --       dapui.open()
    --     end
    --     dap.listeners.before.launch.dapui_config = function()
    --       dapui.open()
    --     end
    --     dap.listeners.before.event_terminated.dapui_config = function()
    --       dapui.close()
    --     end
    --     dap.listeners.before.event_exited.dapui_config = function()
    --       dapui.close()
    --     end
    --     -- set a vim motion for <Space> + d + t to toggle a breakpoint at the line
    --     -- where the cursor is currently on
    --     vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint,
    --       { desc = "Debug: Toggle Breakpoint" }
    --     )
    --     -- set a vim motion for <Space> + d + s to start the debugger and launch
    --     -- the debugging ui
    --     vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug: Start/Continue" })
    --     -- set a vim motion to close the debugging ui
    --     vim.keymap.set("n", "<leader>dc", function ()
    --       dapui.close()
    --     end, {desc = "Debug: Close"})

    --     vim.keymap.set('n', '<Leader>dr', function ()
    --       dap.repl.open()
    --     end, { desc = "Debug: Open REPL" })

    --     -- Step controls
    --     vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Debug: Step Up"})
    --     vim.keymap.set("n", "<leader>dj", dap.down, {desc = "Debug: Step Down"})
    --     vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    --     vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    --     vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
    --     vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" })
  end
}
