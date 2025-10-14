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
          path = "~/vaults/personal",
          overrides = {
            notes_subdir = "notes",
            daily_notes = {
              folder = "daily",
            },
          },
        },
        {
          name = "work",
          path = "~/vaults/work",
          overrides = {
            notes_subdir = "notes",
            daily_notes = {
              folder = "daily",
            },
          },
        },
      },

      notes_subdir = "notes",

      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
      },

      -- templates
      templates = {
        folder = vim.fn.expand("~/vaults/templates"),
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      ui = {
        enable = true,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
      },

      disable_frontmatter = true,

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

    -- keymaps
    vim.keymap.set("n", "<leader>ow", ":ObsidianWorkspace<CR>", { desc = "Cambiar workspace" })
    vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "Abrir en Obsidian app" })
    vim.keymap.set("n", "<leader>on", ":ObsidianNew ", { desc = "Nueva nota Obsidian" })
    vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { desc = "Nota diaria" })
    vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Buscar notas" })
    vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { desc = "Cambiar nota" })
  end,
}
