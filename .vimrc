set nocompatible
filetype off
set shell=/bin/bash

call plug#begin('~/.vim/plugged')

" Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
" Plug 'vim-syntastic/syntastic'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'w0rp/ale'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

call plug#end()
filetype plugin indent on
filetype plugin on

set bs=2

set mouse=a

set list
set listchars=tab:»-,trail:⋅,eol:¬,extends:»,precedes:«,nbsp:%
set ignorecase
set smartcase

set showtabline=2

" set timeoutlen=1000 ttimeoutlen=0

set hlsearch

let g:indentLine_enabled = 1
" let g:indentLine_color_term = 239
let g:indentLine_char = '|'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 1

" VIM SOLARIZED!!
syntax enable
set background=dark
silent! colorscheme solarized

" Spell check
syntax enable
setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline
syntax on

" let g:jedi#popup_select_first = 0
" let g:jedi#show_call_signatures = "1"
" let g:jedi#use_tabs_not_buffers = 1

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


let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_tests = 1

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

au VimEnter * highlight SignColumn ctermbg=10
au VimEnter * highlight clear ALEErrorSign
au VimEnter * highlight clear ALEWarningSign

"set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'isort', 'yapf'],
\   'rust': ['rustfmt'],
\}
let g:ale_linters = {
    \ 'python': ['flake8', 'pylint'],
    \ 'rust': ['rustfmt', 'rls'],
    \ }
nmap <Leader>x <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_detail)
"nmap <silent> <C-h> <Plug>(ale_hover)

"let g:syntastic_python_pylint_exe = 'python3 -m pylint'
"let g:syntastic_python_checkers = ['pylint']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs = 1

" pep8 indent
let g:python_pep8_indent_hang_closing = 1

" snippets
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" Git
" git-blame activate by leader b
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

filetype indent plugin on

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent

"set number

" highlight the length over 80column
" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" match OverLength /\%81v.*/

"setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline


set smartindent

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_key_invoke_completion = '<C-Space>'
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_goto_buffer_command = 'new-tab'
" nnoremap <leader>d :YcmCompleter GoTo<CR>
" nnoremap <leader>r :YcmCompleter GoToReferences<CR>
"
"
" let g:ycm_semantic_triggers =  {
"   \   'c': ['->', '.'],
"   \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"   \            're!\[.*\]\s'],
"   \   'ocaml': ['.', '#'],
"   \   'cpp,cuda,objcpp': ['->', '.', '::'],
"   \   'perl': ['->'],
"   \   'php': ['->', '::'],
"   \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
"   \   'python': ['re!from\s+\S+\s+import\s', 'from ', 'import '],
"   \   'ruby,rust': ['.', '::'],
"   \   'lua': ['.', ':'],
"   \   'erlang': [':'],
"   \ }


let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

" Coc completer
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.

inoremap <silent><expr> <C-space> coc#refresh()
inoremap <silent><expr> <C-@> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent> <C-k> <C-o>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
