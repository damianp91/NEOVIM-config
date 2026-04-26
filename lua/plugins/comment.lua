-- NOTE: Comment create comment or discomment
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- plugin to allow us to automatically comment tsx elements with
    -- the comment plugin
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- gain access to the comment plugins functions
    local comment = require("Comment")
    -- gain access to tsx commenting plugins functions
    local commentsg = require("ts_context_commentstring.integrations.comment_nvim")

    require('ts_context_commentstring').setup({
      enable_autocmd = false,
    })

    -- setup the comment plugin to use ts_context_comment_string to check if we are
    -- attempting to comment out a tsx element
    -- if we are use ts_context_comment_string to comment it out
    comment.setup({
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = '^$',
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = '<leader>Cl',
        ---Block-comment toggle keymap
        block = '<leader>Cb',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap example gc 4 arrow down
        line = 'gc',
        ---Block-comment keymap in selection
        block = 'gb',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = '<leader>Ca',
        ---Add comment on the line below
        below = '<leader>CB',
        ---Add comment at the end of line
        eol = '<leader>Cf',
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}`
        ---`gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = commentsg.create_pre_hook(),
      ---Function to call after (un)comment
      -- post_hook = commentsg.create_post_hook(),
    })
  end,
}
