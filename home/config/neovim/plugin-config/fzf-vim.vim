command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -uu --ignore-dot --column --line-number --no-heading --color=always --glob=!.git/ '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
