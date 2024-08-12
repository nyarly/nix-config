local function on_context_attach(bufnr)
  vim.cmd("hi clear TreesitterContext")
  vim.cmd("hi link TreesitterContext NormalFloat")
  vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
  vim.cmd("hi TreesitterContextLineNumberBottom gui=underline guisp=Grey")
  return true
end

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  on_attach = on_context_attach,
}
