let g:ale_enabled = 0 " q.v. ale_pattern_options
let g:ale_sign_column_always = 1
let g:ale_echo_delay = 90
let g:ale_lint_on_text_changed = "never"
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_linters = {
      \ 'ruby': 'all',
      \ 'markdown': ['languagetool', 'proselint', 'vale']
      \}
      "-- \ 'rust': ['analyzer'],
let g:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace'],
      \'go': ['gofmt', 'remove_trailing_lines', 'trim_whitespace'],
      \'json': ['jq', 'remove_trailing_lines', 'trim_whitespace'],
      \'ruby': ['rubocop', 'remove_trailing_lines', 'trim_whitespace'],
      \'terraform': ['terraform', 'remove_trailing_lines', 'trim_whitespace']
      \}
      "-- \'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],

let g:ale_go_gobuild_options = "-tags 'integration smoke'"

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
