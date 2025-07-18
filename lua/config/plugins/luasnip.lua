
local ls = require "luasnip"
local types = require "luasnip.util.types"

local M = {}

function M.setup()
  ls.config.set_config{
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
          virt_text = {{"<- Choise", "Error"}},
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
  end, {silent = true})

  -- <c-j> is my jump backwards key.
  -- This alvays moves to the previous item within the snippet
  vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, {silent = true})

  -- <c-l> is selecting within a list of options.
  -- This is useful for choice nodes
  vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice()
    end
  end)
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Autocmd to clean up broken fragment states
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
      if (vim.v.event.old_mode == "i" or vim.v.event.old_mode == "s")
        and vim.v.event.new_mode == "n"
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

return M

