function! s:parse_buffer_list(line)
  " 9+1
  let buffer = strpart(a:line, 10)
  return strpart(buffer, 0, match(buffer, '\s\+line\s\d\+$') - 1)
endfunction

function! ccline#complete#buffer#complete(A, L, P)
  let buffers = split(ccline#complete#capture('buffers'), '[\r\n]')
  return ccline#complete#forward_matcher(map(buffers, 's:parse_buffer_list(v:val)'), a:A)
endfunction