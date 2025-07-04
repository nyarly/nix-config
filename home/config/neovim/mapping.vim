function! s:NonSpecialMappings()
  nnoremap <buffer> <F3> <Cmd>MundoToggle<CR>
  ":<C-U>GundoToggle<CR>
  noremap <buffer> <C-P> <Cmd>Files<CR>
  inoremap <buffer> <C-P> <Cmd>Files<CR>
  noremap <buffer> <F4> <Cmd>Buffer<CR>
  inoremap <buffer> <F4> <Cmd>Buffer<CR>
  nnoremap <buffer> <silent> <CR> i<CR><Esc>
  nnoremap <buffer> <silent>  <F6> :TagbarToggle<CR>
  nnoremap <buffer> <silent>  <F5> :TagbarOpenAutoClose<CR>

"imap <buffer> <C-L> <Plug>delimitMateJumpMany
  "like . but for commands

  vmap <buffer> <Up> <ESC>'>gvk
  vmap <buffer> <Down> <ESC>'<gvj
  vmap <buffer> <Left> <gv
  vmap <buffer> <Right> >gv
endfunction

function! s:SetMappings()
  if(! exists("b:mappings_set"))
    let b:mappings_set=1
    if &buftype == ''
      call s:NonSpecialMappings()
    endif
  endif
endfunction

function! DoMake()
  make
  cwin
endfunction

"use gQ for Ex mode anyway
map Q gq

function! s:RgThisFile()
  let name=expand('%:t')
  exec "Rg " . name
endfunction

nmap <Leader>f <Plug>(ale-fix)

tnoremap <A-n> <C-\><C-n><C-w>c
tnoremap <A-x> <C-\><C-n><C-w>c
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-n> <C-w>c
nnoremap <A-x> <C-w>c
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"maybe moving off ALE entirely, or at least use an autocmd
nnoremap WW :ALEFix<CR>:wall<CR>
" nnoremap WW <Cmd>wall<CR>
nnoremap <C-w><C-w> <C-w><C-p>
nnoremap <C-w>w <C-w><C-p>
imap <C-W> <Esc>:
imap <C-H> <C-O>h
imap <C-J> <C-O>j
imap <C-K> <C-O>k
noremap <silent><Leader>] <Esc>:nohls<CR>
noremap <silent><Leader>q <Esc>:nohls<CR>
"<Cmd> mapping would treat <C-R><C-W> as unmapped keys - the current word isn't inserted
inoremap <Leader>q <Esc>:Lines <C-R><C-W><CR>
nnoremap <Leader>q :Lines <C-R><C-W><CR>
nnoremap <Leader>w :Rg<CR>
inoremap <Leader>a <Esc>:Rg \b<C-R><C-W>\b<CR>
nnoremap <Leader>a :Rg \b<C-R><C-W>\b<CR>
vnoremap <Leader>a y:Rg \b<C-R>"\b<CR>
nnoremap <Leader>h <Cmd>set hlsearch \| let @/='\<'.expand("<cword>").'\>'<CR>
"inoremap <Leader>f <Esc>:Files <C-R><C-W><CR> (Files' arg is starting dir)
"nnoremap <Leader>f :Files <C-R><C-W><CR>
inoremap <Leader>s <Cmd>call <sid>RgThisFile()<C-R><C-W><CR>
nnoremap <Leader>s <Cmd>call <sid>RgThisFile()<C-R><C-W><CR>
inoremap jk <Esc>
inoremap jK <Esc>
nnoremap MM <Cmd>Jmake<CR>
nnoremap / /\v
vnoremap / /\v
cmap w!! %!sudo tee > /dev/null %

nnoremap Q @@
nnoremap s "_d
nnoremap ss "_dd
nnoremap S "_D

autocmd BufReadPost,BufNewFile * call s:SetMappings()
