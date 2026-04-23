-- NOTE: DAP (Debug Adapter Protocol) for java
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- ui plugins to make debugging simplier
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  cmd = { "DapContinue", "DapToggleBreakpoint" },
  config = function()
    -- gain access to the dap plugin and its functions
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    -- gain access to the dap ui plugin and its functions
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- set a vim motion for <Space> + d + t to toggle a breakpoint at the line
    -- where the cursor is currently on
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint,
      { desc = "Debug: Toggle Breakpoint" }
    )
    -- set a vim motion for <Space> + d + s to start the debugger and launch
    -- the debugging ui
    vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug: Start" })
    -- set a vim motion to close the debugging ui
    vim.keymap.set("n", "<leader>dc", dapui.close, {desc = "Debug: Close"})

    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Debug: Open REPL" })
  end
}
