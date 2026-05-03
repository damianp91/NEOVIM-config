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
  end
}
