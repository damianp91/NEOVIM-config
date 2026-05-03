local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  -- UI
  dapui.setup()

  require("nvim-dap-virtual-text").setup({
    enabled = true,
    virtual_text = {
      prefix = "●",
    },
  })

  -- events
  dap.listeners.before.attach.dapui = function()
    dapui.open()
  end

  dap.listeners.before.launch.dapui = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated.dapui = function()
    dapui.close()
  end

  dap.listeners.before.event_exited.dapui = function()
    dapui.close()
  end

  local map = vim.keymap.set

  map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  map("n", "<leader>ds", dap.continue, { desc = "Debug: Start/Continue" })
  map("n", "<leader>dc", dapui.close, { desc = "Debug: Close UI" })

  map("n", "<leader>dr", dap.repl.open, { desc = "Debug: REPL" })

  map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
  map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
  map("n", "<leader>du", dap.step_out, { desc = "Step Out" })

  map("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" })
end

return M
