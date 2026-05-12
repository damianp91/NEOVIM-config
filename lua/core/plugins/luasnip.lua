---@diagnostic disable: undefined-field
local ok, ls = pcall(require, 'luasnip')
if not ok then
  vim.notify("LuaSnip not found", vim.log.levels.WARN)
  return
end

local M = {}

function M.setup()
  ls.setup {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged",
  }

  vim.keymap.set({ "i", "s" }, "<C-n>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true, desc = "LuaSnip: Next choice" })

  vim.keymap.set({ "i", "s" }, "<C-p>", function()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, { silent = true, desc = "LuaSnip: Previous choice" })

  vim.keymap.set('i', '<C-x>', function()
    if ls.in_snippet() then
      ls.unlink_current()
    end
  end, { silent = true, desc = 'LuaSnip: Exit snippet' })

  -- Load snippets from various sources
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Snippets personalizados (opcional)
  local snip = ls.snippet
  local text = ls.text_node
  local insert = ls.insert_node
  local choice = ls.choice_node

  -- Snippet de prueba con choices (sin auto-inserción)
  ls.add_snippets("all", {
    snip("elige", {
      text("➤ Elige: "),
      choice(1, {
        text("Opción 1"),
        text("Opción 2"),
        text("Opción 3"),
      }),
      insert(0),
    }),
  })
end

return M
