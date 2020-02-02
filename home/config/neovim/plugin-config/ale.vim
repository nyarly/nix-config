let g:ale_sign_column_always = 1
let g:ale_echo_delay = 90
let g:ale_lint_on_text_changed = "never"
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
      \ 'ruby': 'all',
      \ 'rust': ['rls']
      \}
let g:ale_fixers = {
      \'ruby': 'rubocop',
      \'rust': ['rustfmt']
      \}

let g:ale_rust_rls_toolchain = ''
let g:ale_rust_rls_config = {
      \  'rust': {
      \    'clippy_preference': 'on',
      \  }
      \}
"      \    'cfg_test': 'true'
"      \  }
"      \}
let g:ale_go_gobuild_options = "-tags 'integration smoke'"

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
