---@diagnostic disable: missing-fields
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local lspkind = require("lspkind")local M = {}

function  M.setup()
  cmp.setup({
    experimental = {
      ghost_text = false,
    },
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    window = {
      documentation = {
        border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
      },
      completion = {
        border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          fallback()
        end
      end,{"i", "s"}),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-y>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ["<C-space>"] = cmp.mapping.complete(),
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
    sources = {
      {name = "nvim_lsp"},
      {name = "nvim_lsp_signature_help"},
      {name = "path"},
      {name = "luasnip"},
      {name = "buffer"},
    }
  })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done{map_char = {tex = ""}})

  -- Set configuration for specific filetype
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      {name = 'git'},
    },{
        {name = 'buffer'},
      })
  })

  cmp.setup.filetype({'sql', 'mysql', 'plsql'}, {
    sources = cmp.config.sources({
      {name = 'vim-dadbod-completition'},
      {name = 'buffer'},
    })
  })

  -- Use buffer source for '/' and '?' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = 'buffer'}
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      {name = 'path'}
    }, {
        {name = 'cmdline'}
      })
  })
end

return M

