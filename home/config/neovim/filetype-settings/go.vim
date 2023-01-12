let g:go_fmt_experimental = 1
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_mod_fmt_autosave = 0

" otherwise vim-go closes splits
"let g:go_list_type = "locationlist"
"let g:go_auto_sameids = 1

"set updatetime=100

nmap <Leader>I <Plug>(go-imports)
nmap <Leader>i <Plug>(go-import)
nmap <Leader>? <Plug>(go-info)
nmap <Leader>t <Plug>(go-def-type)
nmap <Leader>e <Plug>(go-iferr)
imap <Leader>e <C-O>:GoIfErr<CR>
" go-def and go-def-pop are already ^] and ^t


set wildignore+=*/vendor/*

augroup GoLegend
  au!
  au FileType go LegendEnable
  au BufWinEnter,BufEnter *.go  LegendEnable
augroup END
