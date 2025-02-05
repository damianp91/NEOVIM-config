---@diagnostic disable: missing-fields
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    -- This for transparency
    notify.setup{background_colour = "#000000"}
    -- This overwrites the vim notify function
    vim.notify = notify.notify
  end,
}
