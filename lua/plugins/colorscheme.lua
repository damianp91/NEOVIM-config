
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Default options:
    require("gruvbox").setup({
      terminal_colors = true,               -- add neovim terminal colors
      undercurl = true,                     -- type of view in letters
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {
        bright_green = "#b8bb26",
        bright_red = "#ff3333",
        dark_blue = "#0059b3",
      },
      overrides = {
        Normal = { bg = "#161616" },
        Pmenu = { bg = "#121618", fg = "#c2bdbb" },         -- Backgroud menu
        PmenuSel = { bg = "#458588", fg = "#fbf1c7" },      -- Item select
        PmenuSbar = { bg = "#282828" },                     -- Scroll bar
        PmenuThumb = { bg = "#dcdcdc" },                    -- Thumb
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        TelescopeNormal = { bg = "#1c1c1c" },
        TelescopeBorder = { bg = "#1c1c1c" },
        TelescopePromptNormal = { bg = "#1c1c1c" },
        TelescopePromptBorder = { bg = "#1c1c1c" },
        TelescopeResultsNormal = { bg = "#1c1c1c" },
        TelescopeResultsBorder = { bg = "#1c1c1c" },
        TelescopePreviewNormal = { bg = "#1c1c1c" },
        TelescopePreviewBorder = { bg = "#1c1c1c" },
        LspFloatWinNormal = { bg = "#121618" },
        LspInfoBorder = { fg = "#c2bdbb", bg = "#121618" },
        CursorLine = {bg = "#242424"},
      },
      dim_inactive = false,               -- Behaivor such panes or windows inactive
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}

