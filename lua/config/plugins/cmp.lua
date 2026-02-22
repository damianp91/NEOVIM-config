---@diagnostic disable: missing-fields, undefined-field
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require ('nvim-autopairs.completion.cmp')
local lspkind = require('lspkind')
local M = {}

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
        winhighlight =
          "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None"
        ,
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
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
      end, {"i", "s"}),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<C-space>"] = cmp.mapping.complete(),
      -- Mapeos adicionales útiles
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {"i", "s"}),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"}),
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
      }),
    },
    sources = cmp.config.sources({
      {name = "nvim_lsp", priority = 1000},
      {name = "nvim_lsp_signature_help", priority = 900},
      {name = "luasnip", priority = 750},
      {name = "path", priority = 500},
    }, {
        {name = "buffer", priority = 250, keyword_length = 3},
      }),
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
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

  -- Use buffer source for '/' and '?' (if you enabled `native_menu`,
  -- this won't work anymore).
  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = 'buffer'}
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`,
  -- this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      {name = 'path'}
    }, {
        {name = 'cmdline'}
      })
  })

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

