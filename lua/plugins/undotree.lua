-- NOTE: UndoTree Visualizer change history
return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle,
      {desc = "Undotree: Oldest change"}
    )
  end,
}
