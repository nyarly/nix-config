nmap <Leader>I <Plug>(go-imports)
nmap <Leader>i <Plug>(go-import)
nmap <Leader>? <Plug>(go-info)
nmap <Leader>t <Plug>(go-def-type)
nmap <Leader>e <Plug>(go-iferr)
imap <Leader>e <C-O>:GoIfErr<CR>
" go-def and go-def-pop are already ^] and ^t

LegendEnable
set wildignore+=*/vendor/*
