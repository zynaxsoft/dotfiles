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
    function! MyYank()
        if v:event.regname == '-'
            call system(g:win32yank . ' -i --crlf', @-)
        endif
    endfunction
    augroup Yank
        au!
        autocmd TextYankPost * :call MyYank()
    augroup END
    function! MyPaste(mode)
        let @- = system(g:win32yank . ' -o --lf')
        return a:mode
    endfunction
    map <expr> "-p MyPaste('"-p')
    map <expr> "-P MyPaste('"-P')
endif
