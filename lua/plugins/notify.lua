---@diagnostic disable: missing-fields
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
   local notify = require "notify"

    notify.setup ({
      background_colour = "#000000",
      timeout = 5000,
      max_width = 90,
      max_height = 20,
      stages = "fade_in_slide_out",
      fps = 30,
      render = "default",
      top_down = true,
      on_open = function()
        local input = vim.fn.input("Type option: ")
        if input ~= "" then
          print("Output: " .. input)
        end
      end,
      on_close = function()
        print("Closed notify.")
      end,
      animate = false,
    })
    vim.notify = notify.notify
  end,
}


