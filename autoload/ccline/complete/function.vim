function! s:get_user_function()
  let function = split(ccline#complete#capture('function'), '[\r\n]')
  call filter(function, "stridx(v:val,'<SNR>')<0")
  return map(function, 's:parse_function_list(v:val)')
endfunction
function! s:parse_function_list(line)
  let function = strpart(a:line, 9)
  let args = matchstr(function, '(\zs.*\ze)')
  if !empty(args)
    let function = strpart(function, 0, stridx(function, '(') + 1)
  endif
  return function
endfunction

function! ccline#complete#function#complete(A, L, P)
  if !exists('s:session_id') || ccline#session_id() > s:session_id
    let s:user_function = s:get_user_function()
    let s:session_id = ccline#session_id()
  endif
  return sort(ccline#complete#forward_matcher(s:user_function + s:default_function, a:A))
endfunction

let s:default_function = [
\ 'abs(',
\ 'acos(',
\ 'add(',
\ 'and(',
\ 'append(',
\ 'argc()',
\ 'argidx()',
\ 'arglistid(',
\ 'argv(',
\ 'asin(',
\ 'atan(',
\ 'atan2(',
\ 'browse(',
\ 'browsedir(',
\ 'bufexists(',
\ 'buffer_exists(',
\ 'buffer_name(',
\ 'buffer_number(',
\ 'buflisted(',
\ 'bufloaded(',
\ 'bufname(',
\ 'bufnr(',
\ 'bufwinnr(',
\ 'byte2line(',
\ 'byteidx(',
\ 'byteidxcomp(',
\ 'call(',
\ 'ceil(',
\ 'changenr()',
\ 'char2nr(',
\ 'cindent(',
\ 'clearmatches()',
\ 'col(',
\ 'complete(',
\ 'complete_add(',
\ 'complete_check()',
\ 'confirm(',
\ 'copy(',
\ 'cos(',
\ 'cosh(',
\ 'count(',
\ 'cscope_connection(',
\ 'cursor(',
\ 'deepcopy(',
\ 'delete(',
\ 'did_filetype()',
\ 'diff_filler(',
\ 'diff_hlID(',
\ 'empty(',
\ 'escape(',
\ 'eval(',
\ 'eventhandler()',
\ 'executable(',
\ 'exepath(',
\ 'exists(',
\ 'exp(',
\ 'expand(',
\ 'extend(',
\ 'feedkeys(',
\ 'file_readable(',
\ 'filereadable(',
\ 'filewritable(',
\ 'filter(',
\ 'finddir(',
\ 'findfile(',
\ 'float2nr(',
\ 'floor(',
\ 'fmod(',
\ 'fnameescape(',
\ 'fnamemodify(',
\ 'foldclosed(',
\ 'foldclosedend(',
\ 'foldlevel(',
\ 'foldtext()',
\ 'foldtextresult(',
\ 'foreground()',
\ 'function(',
\ 'garbagecollect(',
\ 'get(',
\ 'getbufline(',
\ 'getbufvar(',
\ 'getchar(',
\ 'getcharmod()',
\ 'getcmdline()',
\ 'getcmdpos()',
\ 'getcmdtype()',
\ 'getcmdwintype()',
\ 'getcurpos()',
\ 'getcwd()',
\ 'getfontname(',
\ 'getfperm(',
\ 'getfsize(',
\ 'getftime(',
\ 'getftype(',
\ 'getline(',
\ 'getloclist(',
\ 'getmatches()',
\ 'getpid()',
\ 'getpos(',
\ 'getqflist()',
\ 'getreg(',
\ 'getregtype(',
\ 'gettabvar(',
\ 'gettabwinvar(',
\ 'getwinposx()',
\ 'getwinposy()',
\ 'getwinvar(',
\ 'glob(',
\ 'globpath(',
\ 'has(',
\ 'has_key(',
\ 'haslocaldir()',
\ 'hasmapto(',
\ 'highlightID(',
\ 'highlight_exists(',
\ 'histadd(',
\ 'histdel(',
\ 'histget(',
\ 'histnr(',
\ 'hlID(',
\ 'hlexists(',
\ 'hostname()',
\ 'iconv(',
\ 'indent(',
\ 'index(',
\ 'input(',
\ 'inputdialog(',
\ 'inputlist(',
\ 'inputrestore()',
\ 'inputsave()',
\ 'inputsecret(',
\ 'insert(',
\ 'invert(',
\ 'isdirectory(',
\ 'islocked(',
\ 'items(',
\ 'join(',
\ 'keys(',
\ 'last_buffer_nr()',
\ 'len(',
\ 'libcall(',
\ 'libcallnr(',
\ 'line(',
\ 'line2byte(',
\ 'lispindent(',
\ 'localtime()',
\ 'log(',
\ 'log10(',
\ 'luaeval(',
\ 'map(',
\ 'maparg(',
\ 'mapcheck(',
\ 'match(',
\ 'matchadd(',
\ 'matchaddpos(',
\ 'matcharg(',
\ 'matchdelete(',
\ 'matchend(',
\ 'matchlist(',
\ 'matchstr(',
\ 'max(',
\ 'migemo(',
\ 'min(',
\ 'mkdir(',
\ 'mode(',
\ 'nextnonblank(',
\ 'nr2char(',
\ 'or(',
\ 'pathshorten(',
\ 'pow(',
\ 'prevnonblank(',
\ 'printf(',
\ 'pumvisible()',
\ 'py3eval(',
\ 'pyeval(',
\ 'range(',
\ 'readfile(',
\ 'reltime(',
\ 'reltimestr(',
\ 'remote_expr(',
\ 'remote_foreground(',
\ 'remote_peek(',
\ 'remote_read(',
\ 'remote_send(',
\ 'remove(',
\ 'rename(',
\ 'repeat(',
\ 'resolve(',
\ 'reverse(',
\ 'round(',
\ 'screenattr(',
\ 'screenchar(',
\ 'screencol()',
\ 'screenrow()',
\ 'search(',
\ 'searchdecl(',
\ 'searchpair(',
\ 'searchpairpos(',
\ 'searchpos(',
\ 'server2client(',
\ 'serverlist()',
\ 'setbufvar(',
\ 'setcmdpos(',
\ 'setline(',
\ 'setloclist(',
\ 'setmatches(',
\ 'setpos(',
\ 'setqflist(',
\ 'setreg(',
\ 'settabvar(',
\ 'settabwinvar(',
\ 'setwinvar(',
\ 'sha256(',
\ 'shellescape(',
\ 'shiftwidth()',
\ 'simplify(',
\ 'sin(',
\ 'sinh(',
\ 'sort(',
\ 'soundfold(',
\ 'spellbadword(',
\ 'spellsuggest(',
\ 'split(',
\ 'sqrt(',
\ 'str2float(',
\ 'str2nr(',
\ 'strchars(',
\ 'strdisplaywidth(',
\ 'strftime(',
\ 'stridx(',
\ 'string(',
\ 'strlen(',
\ 'strpart(',
\ 'strridx(',
\ 'strtrans(',
\ 'strwidth(',
\ 'submatch(',
\ 'substitute(',
\ 'synID(',
\ 'synIDattr(',
\ 'synIDtrans(',
\ 'synconcealed(',
\ 'synstack(',
\ 'system(',
\ 'systemlist(',
\ 'tabpagebuflist(',
\ 'tabpagenr(',
\ 'tabpagewinnr(',
\ 'tagfiles()',
\ 'taglist(',
\ 'tan(',
\ 'tanh(',
\ 'tempname()',
\ 'test(',
\ 'tolower(',
\ 'toupper(',
\ 'tr(',
\ 'trunc(',
\ 'type(',
\ 'undofile(',
\ 'undotree()',
\ 'uniq(',
\ 'values(',
\ 'virtcol(',
\ 'visualmode(',
\ 'wildmenumode()',
\ 'winbufnr(',
\ 'wincol()',
\ 'winheight(',
\ 'winline()',
\ 'winnr(',
\ 'winrestcmd()',
\ 'winrestview(',
\ 'winsaveview()',
\ 'winwidth(',
\ 'writefile(',
\ 'xor(',
\ ]
