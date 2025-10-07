require("outline").setup({
  symbols = {
    icon_fetcher = function(kind, bufnr, symbol)
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
      return kind:sub(1, 1)
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
