return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = {
    "ObsidianNew",
    "ObsidianToday",
    "ObsidianSearch",
    "ObsidianQuickSwitch",
    "ObsidianWorkspace",
    "ObsidianOpen",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    -- Configurar conceallevel para markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })

    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand("~/vaults/personal"),
          overrides = {
            daily_notes = {
              folder = "daily",
              date_format = "%Y-%m-%d",
              template = "daily.md",
            },
          },
        },
        {
          name = "work",
          path = vim.fn.expand("~/vaults/work/"),
          overrides = {
            daily_notes = {
              folder = "daily",
              date_format = "%Y-%m-%d",
              template = "daily.md",
            },
          },
        },
      },

      -- templates
      templates = {
        folder = vim.fn.expand("~/vaults/templates"),
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },

        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#fb4934" },
          ObsidianDone = { bold = true, fg = "#b8bb26" },
          ObsidianRightArrow = { bold = true, fg = "#fabd2f" },
          ObsidianTilde = { bold = true, fg = "#fe8019" },
          ObsidianImportant = { bold = true, fg = "#fb4955" },
          ObsidianBullet = { bold = true, fg = "#83a598" },
          ObsidianRefText = { underline = true, fg = "#d3869b" },
          ObsidianExtLinkIcon = { fg = "#8ec07c" },
          ObsidianTag = { italic = true, fg = "#fabd55" },
          ObsidianBlockID = { italic = true, fg = "#928374" },
          ObsidianHighlightText = { bg = "#504945" },
        },
      },

      disable_frontmatter = false,

      note_frontmatter_func = function(note)
        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          created = os.date("%Y-%m-%d %H:%M"),
        }

        if note.title then
          note:add_alias(note.title)
        end

        return out
      end,

      mappings = {
        -- Seguir links con gf
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle checkbox con <leader>ch
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Usar el enter para no tener que usar gf o <leader>ch
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Format notes
      note_id_func = function(title)
        -- Convierte "Mi Nota" en "mi-nota"
        if title ~= nil then
          return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          return tostring(os.time())
        end
      end,

      -- completitions
      completion = {
        nvim_cmp = true,
        min_chars = 2;
      },

      -- picker
      picker = {
        name = "telescope.nvim",
      },

      -- open app
      follow_url_func = function(url)
        vim.fn.jobstart({"xdg-open", url})
      end,
    })
  end,
}
