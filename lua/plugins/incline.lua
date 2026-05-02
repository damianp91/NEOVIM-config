-- NOTE: Incline view name of file in each buffer
return {
  -- Adding a filename to the Top Right
  "b0o/incline.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local devicons = require("nvim-web-devicons")

    require("incline").setup({
      debounce_threshold = {
        falling = 50,
        rising = 10
      },
      hide = {
        cursorline = "smart",
        focused_win = false,
        only_win = false
      },
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            group = "NormalFloat"
          },
          InclineNormalNC = {
            default = true,
            group = "NormalFloat"
          }
        },
      },
      ignore = {
        buftypes = "special",
        filetypes = {},
        floating_wins = true,
        unlisted_buffers = true,
        wintypes = "special"
      },
      render = function(props)
        -- If there are two or more windows
        local visible_windows = 0
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          -- just count non-float windows
          if config.relative == '' then
            visible_windows = visible_windows + 1
          end
        end
        if visible_windows <= 1 then
          return ""
        end

        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ":t")
        if filename == '' then filename = '[No Name]' end

        local ext = vim.fn.fnamemodify(bufname, ":e")
        local icon, icon_color = devicons.get_icon(filename, ext, { default = true })

        local modified = vim.bo[props.buf].modified

        return {
          { " ", icon, " ", guifg = icon_color },
          { filename, gui = modified and "italic" or "none" },
          modified and { "󰐼 ", guifg = "#8a0000" } or "",
          " ",
        }
      end,
      window = {
        margin = {
          horizontal = 1,
          vertical = 1
        },
        options = {
          signcolumn = "no",
          wrap = false
        },
        overlap = {
          borders = true,
          statusline = false,
          tabline = false,
          winbar = false
        },
        padding = 1,
        padding_char = " ",
        placement = {
          horizontal = "right",
          vertical = "top"
        },
        width = "fit",
        winhighlight = {
          active = {
            EndOfBuffer = "None",
            Normal = "InclineNormal",
            Search = "None"
          },
          inactive = {
            EndOfBuffer = "None",
            Normal = "InclineNormalNC",
            Search = "None"
          }
        },
        zindex = 50
      }
    })
  end,
}
