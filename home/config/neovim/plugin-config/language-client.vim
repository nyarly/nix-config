function! LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <silent> <leader>rx :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer> <silent> <F6> :call LanguageClient_contextMenu()<CR>

    setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  endif
endfunction

autocmd FileType * call LC_maps()

let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ }
