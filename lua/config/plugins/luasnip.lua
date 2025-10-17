---@diagnostic disable: undefined-field
local ls = require ('luasnip')
local types = require ('luasnip.util.types')

local M = {}

function M.setup()
  ls.config.setup {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into even if you move outside of the selection
    history = true,
    -- This one is cool cause if you have dynamic snippets, it updatesas type!
    updateevents = "TextChanged,TextChangedI",
    -- Autosnippets:
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = {{"<- Choice", "Error"}},
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = {{"<- Insert", "Comment"}},
        },
      },
    },
  }
  -- <c-k> is my expansion key
  -- this will expand the current item or jump to the next item within the snippet.
  vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, {silent = true, desc = "LuaSnip: Expand or jump forward"})

  -- <c-j> is my jump backwards key.
  -- This alvays moves to the previous item within the snippet
  vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, {silent = true, desc = "LuaSnip: Jump backward"})

  -- <c-l> is selecting within a list of options.
  -- This is useful for choice nodes
  vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, {silent = true, desc = "LuaSnip: Change choice"})

  -- Navigate through choice nodes with Tab/Shift-Tab
  vim.keymap.set("s", "<Tab>", function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end, {silent = true, desc = "LuaSnip: Jump forward in snippet"})

  vim.keymap.set("s", "<S-Tab>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, {silent = true, desc = "LuaSnip: Jump backward in snippet"})

  -- Load snippets from various sources
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Autocmd to clean up broken fragment states
  vim.api.nvim_create_autocmd({"ModeChanged"}, {
    pattern = "*",
    callback = function()
      local event = vim.v.event
      -- Verificar que event y sus campos existan
      if event and event.old_mode and event.new_mode then
        if (event.old_mode == "i" or event.old_mode == "s") and event.new_mode == "n" then
          -- Safely unlink current snippet
          pcall(function()
            ls.unlink_current()
          end)
        end
      end
    end,
    desc = "LuaSnip: Unlink snippet when leaving insert/select mode"
  })

  -- Autocmd adicional para limpiar al salir de buffers
  vim.api.nvim_create_autocmd({"BufDelete", "BufWipeout"}, {
    callback = function()
      pcall(function()
        ls.unlink_current()
      end)
    end,
    desc = "LuaSnip: Clean up on buffer close"
  })
end

return M

