local function choose_icon(kind)
  -- local icon = require('outline.config').o.symbols.icons[kind].icon
  return require('outline.config').o.symbols.icons[kind].icon
  -- return kind:sub(1, 1)
end

require("outline").setup({
  symbols = {
    icon_fetcher = function(kind, bufnr, symbol)
      -- ◉◍◎◯☐☑☒🔏🔐🔑🔒🔓
      local access_icons = { public = '🔓', protected = '◉', private = '🔒' }
      local icon = choose_icon(kind)
      -- ctags provider might add an `access` key
      -- vim.notify("outline-symbol: " .. vim.inspect(symbol))

      if symbol and symbol.access then
        return icon .. ' ' .. access_icons[symbol.access]
      end
      return icon
    end,
    -- icon_source = "lspkind", requires a separate plugin
    icons = {
      File = { icon = 'F', hl = 'Identifier' },
      Module = { icon = 'M', hl = 'Include' },
      Namespace = { icon = 'ns', hl = 'Include' },
      Package = { icon = 'P', hl = 'Include' },
      Property = { icon = 'P', hl = 'Identifier' },
      Field = { icon = 'f', hl = 'Identifier' },
      Constructor = { icon = 'c', hl = 'Special' },
      Interface = { icon = 'i', hl = 'Type' },
      Function = { icon = 'ƒ', hl = 'Function' },
      Variable = { icon = 'v', hl = 'Constant' },
      Constant = { icon = 'C', hl = 'Constant' },
      Array = { icon = '[]', hl = 'Constant' },
      EnumMember = { icon = 'E', hl = 'Identifier' },
      Component = { icon = 'C', hl = 'Function' },
      Fragment = { icon = 'F', hl = 'Constant' },
      -- ccls
      TypeAlias = { icon = 'T', hl = 'Type' },
      Parameter = { icon = 'p', hl = 'Identifier' },
      StaticMethod = { icon = 'S', hl = 'Function' },
      Macro = { icon = 'M', hl = 'Function' },
    }
  },
  symbol_folding = {
    -- markers = { '⩾', '⩛' },
    -- markers = { '🮥', '🮦' },
    -- markers = { '🗀', '🗁' },
    -- markers = { '⯈', '⯆' },
    markers = { '◑', '◒' },
  },
  -- ›⋁〉◑◒⩥⩛⩾⩔⯈⯆🖛🖣🗀🗁🗂🮥🮦
})

vim.keymap.set({ 'n', 'i', 'v' }, '<F5>', '<cmd>Outline<CR>')
