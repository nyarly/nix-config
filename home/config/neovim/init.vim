if &shell =~# 'fish$'
  set shell=/bin/sh
endif

"packloadall " plugins are added as packages before init.vim

runtime! ftdetect/UltiSnips.vim

set autowrite
set autowriteall
set expandtab
set modeline
set sw=2
set ts=2
set scrolloff=4
set pastetoggle=[23~
set gdefault
set mouse=a

"O	message for reading a file overwrites any previous message.
"Also for quickfix message (e.g., ":cn").
"t	truncate file message at the start if it is too long to fit
"T	truncate other messages in the middle if they are too long to
"I	don't give the intro message when starting Vim |:intro|.
"c	don't give |ins-completion-menu| messages.  For example,
"   c really useful for echodoc
set shortmess+=IcOtT
set number
set cursorline
set noshowmode
set foldlevelstart=2
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

set title

set wildmode=list:longest

set undodir="~/.config/.nvim/undo"
set undofile

set clipboard+=unnamed
set clipboard+=unnamedplus

" per https://www.hillelwayne.com/post/intermediate-vim/
set lazyredraw
set smartcase

set t_ut= "Needed to get non-text background colors to work correctly in urxvt + tmux

let g:solarized_termcolors=16
set background=light
colorscheme solarized
nnoremap <F12> "*p

set tags+=.git/bundle-tags

if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source " .path
  endfor
endif

set inccommand=split
" Debugging my 'number' getting disabled:
" c.f. https://github.com/neovim/neovim/issues/8739
" au OptionSet number echom execute('verbose set number?')
