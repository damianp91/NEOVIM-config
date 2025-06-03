return {
  "akinsho/toggleterm.nvim",
  config = function()
    require('toggleterm').setup({
      -- Size horizontal mode (number of lines)
      size = 20,

      -- Settings for vertical mode
      shade_terminals = true,
      shading_factor = 3,
      persist_size = true,

      -- Settings for float terminal
      float_opts = {
        border = 'curved',       -- or 'single', 'double', 'shadow', etc.
        width = function() return math.floor(vim.o.columns * 0.7) end,  -- 80% weight
        height = function() return math.floor(vim.o.lines * 0.7) end,   -- 80% height
        winblend = 75,            -- Tranparency (0-100)
      },

      on_open = function(term)
        if term.direction == "horizontal" then
          vim.cmd('resize 15')   -- Tamaño para horizontal
        elseif term.direction == "vertical" then
          vim.cmd('vertical resize 80')  -- Ancho para vertical
        end
      end,
    })
  end,
}
