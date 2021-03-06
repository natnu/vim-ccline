let s:source = {}

function! ccline#complete#source#color#define() abort
  return deepcopy(s:source)
endfunction

function! s:source.init() abort
  let self.candidates = map(
  \ globpath(&runtimepath, 'colors/*.vim', 0, 1),
  \ 'fnamemodify(v:val, ":t:r")')
endfunction

function! s:source.complete(cmdline, arg, line, pos) abort
  return sort(ccline#complete#forward_matcher(self.candidates, a:arg))
endfunction
