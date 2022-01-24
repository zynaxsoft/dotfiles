function! IsWSL()
  if has("unix")
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
      return 1
    endif
  endif
  return 0
endfunction

let g:is_wsl = IsWSL()
if is_wsl
    let g:win32yank = $HOME . '/dotfiles/bin/win32yank.exe'
    let g:clipboard = {
    \   'name': 'wslClipboard',
    \   'copy': {
    \      '+': win32yank.' -i --crlf',
    \      '*': win32yank.' -i --crlf',
    \    },
    \   'paste': {
    \      '+': win32yank.' -o --lf',
    \      '*': win32yank.' -o --lf',
    \   },
    \   'cache_enabled': 1,
    \ }
endif
