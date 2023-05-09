require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load()

-- c.f. :help luasnip

vim.keymap.set("v", '<Leader>F', function()
  vim.api.nvim_input("ec")
  require('luasnip.extras.otf').on_the_fly()
end)
vim.keymap.set("i", '<Leader>F', function() require('luasnip.extras.otf').on_the_fly() end)

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files()
end, {desc = "Live edit LuaSnip files"})
