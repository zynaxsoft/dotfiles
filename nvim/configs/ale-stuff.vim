" pep8
let g:ale_python_pylint_executable = '/usr/bin/python3'
let g:ale_python_pylint_options = '-m pylint --errors-only --disable E1101,E0401'
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_flake8_options = '--ignore "I100, I101, E123, W503, F405"'
let g:ale_python_autopep8_executable = '/usr/bin/python3'
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = '/usr/bin/python3'
let g:ale_python_isort_options = '-m isort'
"let g:ale_python_black_executable = '/usr/bin/python3'
"let g:ale_python_black_options = '-m black'
let g:ale_python_yapf_executable = '/usr/bin/yapf'
let g:ale_python_yapf_options = ''

let g:ale_python_pylint_use_global = 1
let g:ale_completion_enabled = 0


let g:ale_rust_cargo_target_dir = '/tmp/rust-analyzer-check/'
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_examples = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_default_feature_behavior = 'all'
let g:ale_rust_rustfmt_options = '--edition 2018'

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_sign_error = '🤔'
let g:ale_sign_warning = '😡'

"let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 4

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'isort', 'yapf'],
\   'rust': ['rustfmt'],
\}
let g:ale_linters = {
    \ 'python': ['flake8', 'pylint'],
    \ 'rust': ['analyzer', 'rustfmt', 'cargo'],
    \ }
nmap <Leader>x <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_detail)
"nmap <silent> <C-h> <Plug>(ale_hover)

au VimEnter * highlight SignColumn ctermbg=10 guibg=#073642
au VimEnter * highlight clear ALEErrorSign
au VimEnter * highlight clear ALEWarningSign


