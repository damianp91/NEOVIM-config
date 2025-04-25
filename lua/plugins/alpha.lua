
return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {

      " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    }

    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values
    local file_type = require('config.fileType')

    function _G.file_project()
      local langs = {
        { name = " Java",
          key = "java",
          options = {
            {label = "  Gradle", key = "gradle"},
            {label = " Maven", key = "maven" } ,
          }
        }
        -- Future languanges
      }

      local langs_by_key = {}
      for _, lang in ipairs(langs) do
        langs_by_key[lang.key] = lang
      end

      pickers.new({}, {
        prompt_title = "Select Lenguage",
        finder = finders.new_table({
          results = langs,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.name,
              ordinal = entry.name
            }
          end
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selected_entry = action_state.get_selected_entry().value
            actions.close(prompt_bufnr)

            local lang_key = selected_entry.key
            local lang = langs_by_key[lang_key]

            if lang and lang.options then
              pickers.new({}, {
                prompt_title = "Select type of " .. lang.name,
                finder = finders.new_table({
                  results = lang.options,
                  entry_maker = function(entry)
                    return {
                      value = entry,
                      display = entry.label,
                      ordinal = entry.label
                    }
                  end
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr2)
                  actions.select_default:replace(function()
                    local selected_option = action_state.get_selected_entry().value
                    actions.close(prompt_bufnr2)

                    local option_key = selected_option.key

                    if file_type[lang_key] and file_type[lang_key][option_key] then
                      file_type[lang_key][option_key]()
                    else
                      vim.notify("Don't find " .. lang_key .. " - " .. option_key, vim.log.levels.ERROR)
                    end
                  end)
                  return true
                end
              }):find()
            end
          end)
          return true
        end
      }):find()
    end

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New File", ":lua file_project()<CR>"),
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("h", "󰋗  Help Info", ":Telescope help_tags<CR>"),
      dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
    }

    local alpha = require("alpha")
    local layout = {
      { type = "padding", val = 12 },       -- Top space
      dashboard.section.header,
      { type = "padding", val = 2 },        -- Space between heater an botton
      dashboard.section.buttons,
      { type = "padding", val = 1 },        -- Space between los botton and footer
      dashboard.section.footer,
    }

    dashboard.config.layout = layout
    alpha.setup(dashboard.config)
  end,
}

