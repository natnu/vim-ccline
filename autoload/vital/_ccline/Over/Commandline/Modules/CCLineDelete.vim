scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:module = {
\	"name" : "CCLineDelete",
\}
function! s:module.on_char_pre(cmdline)
  if a:cmdline.is_input("\<C-h>")
  \ || a:cmdline.is_input("\<BS>")
    if empty(a:cmdline.getline())
      call a:cmdline.setchar('')
      return a:cmdline.exit(1)
    else
      call a:cmdline.remove_prev()
      call a:cmdline.setchar('')
    endif
  elseif a:cmdline.is_input("\<Del>")
    call a:cmdline.remove_pos()
    call a:cmdline.setchar('')
  elseif a:cmdline.is_input("\<C-w>")
    let word = a:cmdline.backward_word()
    let backward = a:cmdline.backward()[ : -strlen(word)-1 ]
    call a:cmdline.setline(backward . a:cmdline.pos_char() . a:cmdline.forward())
    call a:cmdline.setline(strchars(backward))
    call a:cmdline.setchar('')
  elseif a:cmdline.is_input("\<C-u>")
    call a:cmdline.setline(a:cmdline.pos_char() . a:cmdline.forward())
    call a:cmdline.setline(0)
    call a:cmdline.setchar('')
  endif
endfunction


function! s:make()
  return deepcopy(s:module)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
