let g:go_fmt_experimental = 1
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_mod_fmt_autosave = 0

" otherwise vim-go closes splits
"let g:go_list_type = "locationlist"
"let g:go_auto_sameids = 1

"set updatetime=100

augroup GoLegend
  au!
  au BufWinEnter,BufEnter *.go  LegendEnable
augroup END
