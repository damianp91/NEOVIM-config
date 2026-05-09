-- TODO: ok todo
-- WARN: ok warm
-- NOTE: ok note
-- FIX: ok fix
-- HACK: ok hack
-- TEST: jfd
-- PERF: dfs
-- NOTE: Todocoments tags in comments
return {
  -- Quickly Jump through the todo tags
  "folke/todo-comments.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup({
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          -- a set of other keywords that all map to this FIX keywords
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning", alt = { "DON SKIP" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "READ", "COLORS" } },
        TEST = { icon = "󰙨 ", color = "test", alt = {
          "TESTING", "PASSED", "FAILED" }
        },
      },
      todo = {
        telescope = {
          enabled = true,
          sort_by = "priority"
        }
      }
    })

    -- keymaps moved to config/keymaps.lua under Notes group
  end,
}
