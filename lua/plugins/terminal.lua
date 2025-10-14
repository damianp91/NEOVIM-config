return {
  "akinsho/toggleterm.nvim",
  config = function()
    require('toggleterm').setup({
      -- Size horizontal mode (number of lines)
      size = 15,

      -- Settings for vertical mode
      shade_terminals = true,
      shading_factor = 3,
      persist_size = true,

      -- Settings for float terminal
      float_opts = {
        border = 'curved',       -- or 'single', 'double', 'shadow', etc.
        width = function() return math.floor(vim.o.columns * 0.6) end,  -- 70% weight
        height = function() return math.floor(vim.o.lines * 0.6) end,   -- 70% height
        winblend = 8,            -- Tranparency (0-100)
      },

      on_open = function(term)
        if term.direction == "horizontal" then
          vim.cmd('resize 15')   -- Size horizontal
        elseif term.direction == "vertical" then
          vim.cmd('vertical resize 80')  -- Weigth vertical
        end
      end,
    })
  end,
}
