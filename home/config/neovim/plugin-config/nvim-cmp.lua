
local cmp = require 'cmp'

vim.o.completeopt = "menuone,noinsert,noselect"

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'luasnip' },
  },

  preselect = cmp.PreselectMode.None,

  completion = {
    completeopt = vim.o.completeopt
  },

  snippet = {
    expand = function(args)
      local luasnip = require 'luasnip'
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          -- select = true, -- a tad too aggresive
        }
      else
        fallback()
      end
    end,
    ['<Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require 'luasnip'
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require 'luasnip'
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ["<C-e>"] = cmp.mapping.close(),
  }),
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, { {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      } })
})

cmp.setup.filetype({'markdown'}, {
  enabled = false, -- could be a function
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  }
})

vim.api.nvim_create_user_command("CmpEnable", "lua require('cmp').setup.buffer({enabled = true})", {
    bar = true,
    desc = "enable cmp completions for this buffer"
  })
vim.api.nvim_create_user_command("CmpDisable", "lua require('cmp').setup.buffer({enabled = false})", {
    bar = true,
    desc = "disable cmp completions for this buffer"
  })
vim.api.nvim_create_user_command("LspEnable", "lua vim.diagnostic.enable()", {
    bar = true,
    desc = "enable LSP diagnostics"
  })
vim.api.nvim_create_user_command("LspDisable", "lua vim.diagnostic.disable()", {
    bar = true,
    desc = "disable LSP diagnostics"
  })

cmp.setup.buffer {
  sources = cmp.config.sources(
    {{name = 'conventionalcommits'}},
    {{name = 'buffer'}}
  ),
}
