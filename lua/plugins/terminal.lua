return {
  "akinsho/toggleterm.nvim",
  config = function()
    require('toggleterm').setup()
    vim.keymap.set('n', '<leader>th', function()
      vim.cmd("ToggleTerm direction=horizontal")
    end)
    vim.keymap.set('n', '<leader>tv', function()
      vim.cmd("ToggleTerm direction=vertical")
    end)
    vim.keymap.set('n', '<leader>tf', function()
      vim.cmd("ToggleTerm direction=float")
    end)
  end,
}
