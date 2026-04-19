---@diagnostic disable: undefined-field
local ok, ls = pcall(require, 'luasnip')
if not ok then return end

local M = {}

function M.setup()
  ls.setup {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  }

  -- Move in nodes
  vim.keymap.set({"i", "s"}, "<C-l>", function ()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, {desc = "LuaSnip: Next node"})

  vim.keymap.set({"i", "s"}, "<C-h>", function ()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, {desc = "LuaSnip: Prev node"})

  -- Load snippets from various sources
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Autocmd to clean up broken fragment states
  vim.api.nvim_create_autocmd({"ModeChanged"}, {
    pattern = "*",
    callback = function()
      local event = vim.v.event
      -- Verificar que event y sus campos existan
      if event and event.old_mode and event.new_mode then
        if event.old_mode:match("[is]") and event.new_mode == "n" then
          -- Safely unlink current snippet
          pcall(ls.unlink_current)
        end
      end
    end,
    desc = "LuaSnip: Unlink snippet when leaving insert/select mode"
  })

  -- Autocmd adicional para limpiar al salir de buffers
  vim.api.nvim_create_autocmd({"BufDelete", "BufWipeout"}, {
    callback = function()
      pcall(ls.unlink_current)
    end,
    desc = "LuaSnip: Clean up on buffer close"
  })
end

return M
