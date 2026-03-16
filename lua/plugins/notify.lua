-- NOTE: float messages in the screen
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    background_colour = "#121618",
    timeout = 6000,
    max_width = 90,
    max_height = 20,
    stages = "fade_in_slide_out",
    fps = 30,
    render = "default",
    top_down = true,
  }
}
