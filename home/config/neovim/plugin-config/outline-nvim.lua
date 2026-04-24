local function choose_icon(kind)
  -- local icon = require('outline.config').o.symbols.icons[kind].icon
  if kind == "Method" then
    return 'ƒ'
  elseif kind == "Function" then
    return 'ƒ'
  elseif kind == "Enum" then
    return 'ℰ'
  elseif kind == "Struct" then
    return '𝓢'
  elseif kind == "TypeParameter" then
    return '𝙏'
  end
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
      if symbol and symbol.access then
        return icon .. ' ' .. access_icons[symbol.access]
      end
      return icon
    end,
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
