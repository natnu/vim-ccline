function! ccline#complete#complete(args)
  let [A, L, P] = a:args
  let backward = strpart(L, 0, P)
  return call(s:get_complete(backward), a:args)
endfunction

function! s:get_complete(line)
  if !exists('s:user_command')
    let s:user_command = s:get_user_commands()
  endif
  let exprs = s:parse_commandline(a:line)
  if empty(exprs)
    return s:complete['command']
  endif
  let current_expr = exprs[len(exprs) - 1]
  if empty(current_expr)
    return s:complete['command']
  endif
  let all_command = extend(s:default_command, s:user_command)
  let command_complete = 'command'

  for command in current_expr
    if !has_key(all_command, command)
      " not found
      let command_complete = 'null'
      break
    endif
    let command_dict = all_command[command]
    if !has_key(command_dict, 'complete')
      " requires no arguments
      let command_complete = 'null'
      break
    endif
    let command_complete = command_dict.complete
    if empty(command_complete)
      " requires no arguments
      let command_complete = 'null'
      break
    endif
    if !has_key(s:complete, command_complete)
      " complete option not found
      let command_complete = 'null'
      break
    endif
    if command_complete != 'command'
      break
    endif
  endfor
  return s:complete[command_complete]
endfunction

function! s:parse_commandline(line)
  let over = (a:line =~# '\s\+$')
  let exprs = split(a:line, '|')
  call map(exprs, 'split(v:val)')
  if !over
    try
      let last_word_index = len(exprs[len(exprs)-1]) - 1
      call remove(exprs[len(exprs)-1], last_word_index)
    catch
    endtry
  endif
  return exprs
endfunction



function! s:get_user_commands()
  redir => commands
  silent command
  redir END
  let result = {}
  let c = split(commands, '[\r\n]')
  call remove(c, 0)
  for line in c
    let p = s:parse_command_list(line)
    let result[p[0]] = p[1]
  endfor
  return result
endfunction
function! s:parse_command_list(line)
  let first = strpart(a:line, 0, 2)
  let bang = (stridx(first, '!') >= 0)
  let register = (stridx(first, '"') >= 0)
  let buffer_local = (stridx(first, 'b') >= 0)
  let name = matchstr(strpart(a:line, 4), '^[A-Z]\S*')
  let name_len = strlen(name)
  if name_len <= 11
    let args = strpart(a:line, 16, 1)
    let range = matchstr(strpart(a:line, 21), '^\S\+')
    let complete = matchstr(strpart(a:line, 27), '^\S\+')
  else
    let args = strpart(a:line, name_len+5, 1)
    let range = matchstr(strpart(a:line, name_len+10), '^\S\+')
    let complete = matchstr(strpart(a:line, name_len+16), '^\S\+')
  endif
  return [name, {'bang': bang, 'register': register, 'buffer_local': buffer_local, 'args': args, 'range': range, 'complete': complete}]
endfunction

function! s:command_complete(A, L, P)
  if !exists('s:user_command')
    let s:user_command = s:get_user_commands()
  endif
  return sort(filter(keys(extend(s:default_command, s:user_command)), 'v:val =~ ''^'' . a:A'))
endfunction

let s:default_command = {
\ '!': {},
\ '#': {},
\ '&': {},
\ '*': {},
\ '<': {},
\ '=': {},
\ '>': {},
\ '@': {},
\ 'Next': {},
\ 'Print': {},
\ 'X': {},
\ 'abbreviate': {},
\ 'abclear': {},
\ 'aboveleft': {},
\ 'all': {},
\ 'amenu': {},
\ 'anoremenu': {},
\ 'append': {},
\ 'argadd': {},
\ 'argdelete': {},
\ 'argdo': {},
\ 'argedit': {},
\ 'argglobal': {},
\ 'arglocal': {},
\ 'args': {},
\ 'argument': {'complete': ''},
\ 'ascii': {},
\ 'augroup': {'complete': 'augroup'},
\ 'aunmenu': {},
\ 'autocmd': {},
\ 'bNext': {},
\ 'badd': {},
\ 'ball': {},
\ 'bdelete': {},
\ 'behave': {},
\ 'belowright': {},
\ 'bfirst': {},
\ 'blast': {},
\ 'bmodified': {},
\ 'bnext': {},
\ 'botright': {},
\ 'bprevious': {},
\ 'break': {'complete': ''},
\ 'breakadd': {},
\ 'breakdel': {},
\ 'breaklist': {},
\ 'brewind': {},
\ 'browse': {},
\ 'bufdo': {},
\ 'buffer': {'complete': 'buffer'},
\ 'buffers': {},
\ 'bunload': {},
\ 'bwipeout': {},
\ 'cNext': {},
\ 'cNfile': {},
\ 'cabbrev': {},
\ 'cabclear': {},
\ 'caddbuffer': {},
\ 'caddexpr': {},
\ 'caddfile': {},
\ 'call': {'complete': 'function'},
\ 'catch': {'complete': ''},
\ 'cbuffer': {},
\ 'cc': {'complete': ''},
\ 'cclose': {},
\ 'cd': {},
\ 'center': {},
\ 'cexpr': {},
\ 'cfile': {},
\ 'cfirst': {},
\ 'cgetbuffer': {},
\ 'cgetexpr': {},
\ 'cgetfile': {},
\ 'change': {},
\ 'changes': {},
\ 'chdir': {},
\ 'checkpath': {},
\ 'checktime': {},
\ 'clast': {},
\ 'clist': {},
\ 'close': {},
\ 'cmap': {},
\ 'cmapclear': {},
\ 'cmenu': {},
\ 'cnewer': {},
\ 'cnext': {},
\ 'cnfile': {},
\ 'cnoreabbrev': {},
\ 'cnoremap': {},
\ 'cnoremenu': {},
\ 'colder': {},
\ 'colorscheme': {},
\ 'comclear': {},
\ 'command': {'complete': 'command'},
\ 'compiler': {},
\ 'confirm': {},
\ 'continue': {},
\ 'copen': {},
\ 'copy': {},
\ 'cpfile': {},
\ 'cprevious': {},
\ 'cquit': {},
\ 'crewind': {},
\ 'cscope': {},
\ 'cstag': {},
\ 'cunabbrev': {},
\ 'cunmap': {},
\ 'cunmenu': {},
\ 'cwindow': {},
\ 'debug': {},
\ 'debuggreedy': {},
\ 'delcommand': {},
\ 'delete': {},
\ 'delfunction': {},
\ 'delmarks': {},
\ 'diffget': {},
\ 'diffoff': {},
\ 'diffpatch': {},
\ 'diffput': {},
\ 'diffsplit': {},
\ 'diffthis': {},
\ 'diffupdate': {},
\ 'digraphs': {},
\ 'display': {},
\ 'djump': {},
\ 'dlist': {},
\ 'doautoall': {},
\ 'doautocmd': {},
\ 'drop': {},
\ 'dsearch': {},
\ 'dsplit': {},
\ 'earlier': {},
\ 'echo': {'complete': 'function'},
\ 'echoerr': {'complete': 'function'},
\ 'echohl': {},
\ 'echomsg': {'complete': 'function'},
\ 'echon': {'complete': 'function'},
\ 'edit': {},
\ 'else': {'complete': ''},
\ 'elseif': {},
\ 'emenu': {},
\ 'endfor': {'complete': ''},
\ 'endfunction': {'complete': ''},
\ 'endif': {'complete': ''},
\ 'endtry': {'complete': ''},
\ 'endwhile': {'complete': ''},
\ 'enew': {},
\ 'ex': {},
\ 'execute': {},
\ 'exit': {},
\ 'exusage': {},
\ 'file': {},
\ 'files': {},
\ 'filetype': {},
\ 'finally': {},
\ 'find': {},
\ 'finish': {'complete': ''},
\ 'first': {'complete': ''},
\ 'fixdel': {},
\ 'fold': {'complete': ''},
\ 'foldclose': {'complete': ''},
\ 'folddoclosed': {'complete': 'command'},
\ 'folddoopen': {'complete': 'command'},
\ 'foldopen': {'complete': ''},
\ 'for': {},
\ 'function': {},
\ 'global': {},
\ 'goto': {},
\ 'grep': {},
\ 'grepadd': {},
\ 'gui': {},
\ 'gvim': {},
\ 'hardcopy': {},
\ 'help': {},
\ 'helpfind': {},
\ 'helpgrep': {},
\ 'helptags': {},
\ 'hide': {},
\ 'highlight': {},
\ 'history': {},
\ 'iabbrev': {},
\ 'iabclear': {},
\ 'if': {},
\ 'ijump': {},
\ 'ilist': {},
\ 'imap': {},
\ 'imapclear': {},
\ 'imenu': {},
\ 'inoreabbrev': {},
\ 'inoremap': {},
\ 'inoremenu': {},
\ 'insert': {},
\ 'intro': {'complete': ''},
\ 'isearch': {},
\ 'isplit': {},
\ 'iunabbrev': {},
\ 'iunmap': {},
\ 'iunmenu': {},
\ 'join': {},
\ 'jumps': {'complete': ''},
\ 'k': {},
\ 'keepalt': {},
\ 'keepjumps': {},
\ 'keepmarks': {},
\ 'keeppatterns': {},
\ 'lNext': {},
\ 'lNfile': {},
\ 'laddbuffer': {},
\ 'laddexpr': {},
\ 'laddfile': {},
\ 'language': {},
\ 'last': {},
\ 'later': {},
\ 'lbuffer': {},
\ 'lcd': {},
\ 'lchdir': {},
\ 'lclose': {},
\ 'lcscope': {},
\ 'left': {},
\ 'leftabove': {},
\ 'let': {},
\ 'lexpr': {},
\ 'lfile': {},
\ 'lfirst': {},
\ 'lgetbuffer': {},
\ 'lgetexpr': {},
\ 'lgetfile': {},
\ 'lgrep': {},
\ 'lgrepadd': {},
\ 'lhelpgrep': {},
\ 'list': {},
\ 'll': {},
\ 'llast': {},
\ 'llist': {},
\ 'lmake': {},
\ 'lmap': {},
\ 'lmapclear': {},
\ 'lnewer': {},
\ 'lnext': {},
\ 'lnfile': {},
\ 'lnoremap': {},
\ 'loadkeymap': {},
\ 'loadview': {},
\ 'lockmarks': {},
\ 'lockvar': {},
\ 'lolder': {},
\ 'lopen': {},
\ 'lpfile': {},
\ 'lprevious': {},
\ 'lrewind': {},
\ 'ls': {},
\ 'ltag': {},
\ 'lua': {},
\ 'luado': {},
\ 'luafile': {},
\ 'lunmap': {},
\ 'lvimgrep': {},
\ 'lvimgrepadd': {},
\ 'lwindow': {},
\ 'make': {},
\ 'map': {},
\ 'mapclear': {},
\ 'mark': {},
\ 'marks': {},
\ 'match': {},
\ 'menu': {},
\ 'menutranslate': {},
\ 'messages': {},
\ 'mkexrc': {},
\ 'mksession': {},
\ 'mkspell': {},
\ 'mkview': {},
\ 'mkvimrc': {},
\ 'mode': {},
\ 'move': {},
\ 'mzfile': {},
\ 'mzscheme': {},
\ 'nbclose': {},
\ 'nbkey': {},
\ 'nbstart': {},
\ 'new': {},
\ 'next': {},
\ 'nmap': {},
\ 'nmapclear': {},
\ 'nmenu': {},
\ 'nnoremap': {},
\ 'nnoremenu': {},
\ 'noautocmd': {},
\ 'nohlsearch': {},
\ 'noreabbrev': {},
\ 'noremap': {},
\ 'noremenu': {},
\ 'normal': {},
\ 'noswapfile': {},
\ 'number': {},
\ 'nunmap': {},
\ 'nunmenu': {},
\ 'oldfiles': {},
\ 'omap': {},
\ 'omapclear': {},
\ 'omenu': {},
\ 'only': {},
\ 'onoremap': {},
\ 'onoremenu': {},
\ 'open': {},
\ 'options': {},
\ 'ounmap': {},
\ 'ounmenu': {},
\ 'ownsyntax': {},
\ 'pclose': {},
\ 'pedit': {},
\ 'perl': {},
\ 'perldo': {},
\ 'pop': {},
\ 'popup': {},
\ 'ppop': {},
\ 'preserve': {},
\ 'previous': {},
\ 'print': {},
\ 'profdel': {},
\ 'profile': {},
\ 'promptfind': {},
\ 'promptrepl': {},
\ 'psearch': {},
\ 'ptNext': {},
\ 'ptag': {},
\ 'ptfirst': {},
\ 'ptjump': {},
\ 'ptlast': {},
\ 'ptnext': {},
\ 'ptprevious': {},
\ 'ptrewind': {},
\ 'ptselect': {},
\ 'put': {},
\ 'pwd': {},
\ 'py3': {},
\ 'py3do': {},
\ 'py3file': {},
\ 'pydo': {},
\ 'pyfile': {},
\ 'python': {},
\ 'python3': {},
\ 'qall': {},
\ 'quit': {},
\ 'quitall': {},
\ 'read': {},
\ 'recover': {},
\ 'redir': {},
\ 'redo': {},
\ 'redraw': {},
\ 'redrawstatus': {},
\ 'registers': {},
\ 'resize': {},
\ 'retab': {},
\ 'return': {},
\ 'rewind': {},
\ 'right': {},
\ 'rightbelow': {},
\ 'ruby': {},
\ 'rubydo': {},
\ 'rubyfile': {},
\ 'rundo': {},
\ 'runtime': {},
\ 'rviminfo': {},
\ 'sNext': {},
\ 'sall': {},
\ 'sandbox': {},
\ 'sargument': {},
\ 'saveas': {},
\ 'sbNext': {},
\ 'sball': {},
\ 'sbfirst': {},
\ 'sblast': {},
\ 'sbmodified': {},
\ 'sbnext': {},
\ 'sbprevious': {},
\ 'sbrewind': {},
\ 'sbuffer': {},
\ 'scriptencoding': {},
\ 'scriptnames': {},
\ 'scscope': {},
\ 'set': {'complete': 'option'},
\ 'setfiletype': {},
\ 'setglobal': {},
\ 'setlocal': {'complete': 'option'},
\ 'sfind': {},
\ 'sfirst': {},
\ 'shell': {},
\ 'sign': {},
\ 'silent': {},
\ 'simalt': {},
\ 'slast': {},
\ 'sleep': {'complete': ''},
\ 'smagic': {},
\ 'smap': {},
\ 'smapclear': {},
\ 'smenu': {},
\ 'snext': {},
\ 'sniff': {},
\ 'snomagic': {},
\ 'snoremap': {},
\ 'snoremenu': {},
\ 'sort': {},
\ 'source': {},
\ 'spelldump': {},
\ 'spellgood': {},
\ 'spellinfo': {},
\ 'spellrepall': {},
\ 'spellundo': {},
\ 'spellwrong': {},
\ 'split': {},
\ 'sprevious': {},
\ 'srewind': {},
\ 'stag': {},
\ 'startgreplace': {},
\ 'startinsert': {},
\ 'startreplace': {},
\ 'stjump': {},
\ 'stop': {},
\ 'stopinsert': {},
\ 'stselect': {},
\ 'substitute': {},
\ 'sunhide': {},
\ 'sunmap': {},
\ 'sunmenu': {},
\ 'suspend': {},
\ 'sview': {},
\ 'swapname': {},
\ 'syncbind': {},
\ 'syntax': {},
\ 'syntime': {},
\ 't': {},
\ 'tNext': {},
\ 'tab': {},
\ 'tabNext': {},
\ 'tabclose': {},
\ 'tabdo': {},
\ 'tabedit': {},
\ 'tabfind': {},
\ 'tabfirst': {},
\ 'tablast': {},
\ 'tabmove': {},
\ 'tabnew': {},
\ 'tabnext': {},
\ 'tabonly': {},
\ 'tabprevious': {},
\ 'tabrewind': {},
\ 'tabs': {},
\ 'tag': {},
\ 'tags': {},
\ 'tcl': {},
\ 'tcldo': {},
\ 'tclfile': {},
\ 'tearoff': {},
\ 'tfirst': {},
\ 'throw': {},
\ 'tjump': {},
\ 'tlast': {},
\ 'tmenu': {},
\ 'tnext': {},
\ 'topleft': {},
\ 'tprevious': {},
\ 'trewind': {},
\ 'try': {},
\ 'tselect': {},
\ 'tunmenu': {},
\ 'unabbreviate': {},
\ 'undo': {},
\ 'undojoin': {},
\ 'undolist': {},
\ 'unhide': {},
\ 'unlet': {},
\ 'unlockvar': {},
\ 'unmap': {},
\ 'unmenu': {},
\ 'unsilent': {},
\ 'update': {},
\ 'verbose': {},
\ 'version': {},
\ 'vertical': {},
\ 'vglobal': {},
\ 'view': {},
\ 'vimgrep': {},
\ 'vimgrepadd': {},
\ 'visual': {},
\ 'viusage': {},
\ 'vmap': {},
\ 'vmapclear': {},
\ 'vmenu': {},
\ 'vnew': {},
\ 'vnoremap': {},
\ 'vnoremenu': {},
\ 'vsplit': {},
\ 'vunmap': {},
\ 'vunmenu': {},
\ 'wNext': {},
\ 'wall': {},
\ 'while': {},
\ 'wincmd': {},
\ 'windo': {},
\ 'winpos': {},
\ 'winsize': {},
\ 'wnext': {},
\ 'wprevious': {},
\ 'wq': {},
\ 'wqall': {},
\ 'write': {},
\ 'wsverb': {},
\ 'wundo': {},
\ 'wviminfo': {},
\ 'xall': {},
\ 'xit': {},
\ 'xmap': {},
\ 'xmapclear': {},
\ 'xmenu': {},
\ 'xnoremap': {},
\ 'xnoremenu': {},
\ 'xunmap': {},
\ 'xunmenu': {},
\ 'yank': {},
\ 'z': {},
\ '~': {},
\ }


function! s:get_user_functions()
  redir => functions
  silent function
  redir END
  let f = split(functions, '[\r\n]')
  call filter(f, "stridx(v:val,'<SNR>')<0")
  return map(f, 's:parse_function_list(v:val)')
endfunction
function! s:parse_function_list(line)
  let function = strpart(a:line, 9)
  let args = matchstr(function, '(\zs.*\ze)')
  if !empty(args)
    let function = strpart(function, 0, stridx(function, '(') + 1)
  endif
  return function
endfunction

function! s:function_complete(A, L, P)
  if !exists('s:user_function')
    let s:user_function = s:get_user_functions()
  endif
  return sort(filter(s:user_function + s:default_function, 'v:val =~ ''^'' . a:A'))
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


function! s:augroup_complete(A, L, P)
  redir => augroups
  silent augroup
  redir END
  return sort(filter(split(augroups), 'v:val =~ ''^'' . a:A'))
endfunction


function! s:parse_buffer_list(line)
  " 9+1
  let buffer = strpart(a:line, 10)
  return strpart(buffer, 0, match(buffer, '\s\+line\s\d\+$') - 1)
endfunction

function! s:buffer_complete(A, L, P)
  redir => buffers
  silent buffers
  redir END
  let b = split(buffers, '[\r\n]')
  " no sort
  return filter(map(b, 's:parse_buffer_list(v:val)'), 'v:val =~ ''^'' . a:A')
endfunction


function! s:_uniq(list)
	let dict = {}
	for _ in a:list
		let dict[_] = 0
	endfor
	return keys(dict)
endfunction

function! s:buffer_word_complete(A, L, P)
  if !exists('s:buffer_word')
    let s:buffer_word = s:_uniq(filter(split(join(getline(1, '$')), '\W'), '!empty(v:val)'))
  endif
  return sort(filter(s:buffer_word, 'v:val =~ ''^'' . a:A'), 1)
endfunction


function! s:option_complete(A, L, P)
  let backward = strpart(a:L, 0, a:P)
  let option = matchlist(backward, '\s\([a-z]\+\)\s*=\(\w*\)$')
  if !empty(option) && has_key(s:option, option[1])
    return sort(filter(deepcopy(s:option[option[1]]), 'v:val =~ ''^'' . option[2]'))
  else
    return sort(filter(keys(s:option), 'v:val =~ ''^'' . a:A'))
  endif
endfunction

let s:option = {
\ 'all' : [],
\ 'termcap' : [],
\ 'aleph' : [],
\ 'arabic' : [],
\ 'arabicshape' : [],
\ 'allowrevins' : [],
\ 'altkeymap' : [],
\ 'ambiwidth' : [],
\ 'autochdir' : [],
\ 'autoindent' : [],
\ 'autoread' : [],
\ 'autowrite' : [],
\ 'autowriteall' : [],
\ 'background' : ['light', 'dark'],
\ 'backspace' : [],
\ 'backup' : [],
\ 'backupcopy' : [],
\ 'backupdir' : [],
\ 'backupext' : [],
\ 'backupskip' : [],
\ 'binary' : [],
\ 'bomb' : [],
\ 'breakat' : [],
\ 'breakindent' : [],
\ 'breakindentopt' : [],
\ 'bufhidden' : [],
\ 'buflisted' : [],
\ 'buftype' : [],
\ 'casemap' : [],
\ 'cdpath' : [],
\ 'cedit' : [],
\ 'charconvert' : [],
\ 'cindent' : [],
\ 'cinkeys' : [],
\ 'cinoptions' : [],
\ 'cinwords' : [],
\ 'clipboard' : [],
\ 'cmdheight' : [],
\ 'cmdwinheight' : [],
\ 'colorcolumn' : [],
\ 'columns' : [],
\ 'comments' : [],
\ 'commentstring' : [],
\ 'compatible' : [],
\ 'complete' : [],
\ 'concealcursor' : [],
\ 'conceallevel' : [],
\ 'completefunc' : [],
\ 'completeopt' : [],
\ 'confirm' : [],
\ 'copyindent' : [],
\ 'cpoptions' : [],
\ 'cryptmethod' : [],
\ 'cscopepathcomp' : [],
\ 'cscopeprg' : [],
\ 'cscopequickfix' : [],
\ 'cscoperelative' : [],
\ 'cscopetag' : [],
\ 'cscopetagorder' : [],
\ 'cscopeverbose' : [],
\ 'cursorbind' : [],
\ 'cursorcolumn' : [],
\ 'cursorline' : [],
\ 'debug' : [],
\ 'define' : [],
\ 'delcombine' : [],
\ 'dictionary' : [],
\ 'diff' : [],
\ 'diffexpr' : [],
\ 'diffopt' : [],
\ 'digraph' : [],
\ 'directory' : [],
\ 'display' : [],
\ 'eadirection' : [],
\ 'edcompatible' : [],
\ 'encoding' : [],
\ 'endofline' : [],
\ 'equalalways' : [],
\ 'equalprg' : [],
\ 'errorbells' : [],
\ 'errorfile' : [],
\ 'errorformat' : [],
\ 'esckeys' : [],
\ 'eventignore' : [],
\ 'expandtab' : [],
\ 'exrc' : [],
\ 'fileencoding' : [],
\ 'fileencodings' : [],
\ 'fileformat' : [],
\ 'fileformats' : [],
\ 'fileignorecase' : [],
\ 'filetype' : [],
\ 'fillchars' : [],
\ 'fkmap' : [],
\ 'foldclose' : [],
\ 'foldcolumn' : [],
\ 'foldenable' : [],
\ 'foldexpr' : [],
\ 'foldignore' : [],
\ 'foldlevel' : [],
\ 'foldlevelstart' : [],
\ 'foldmarker' : [],
\ 'foldmethod' : [],
\ 'foldminlines' : [],
\ 'foldnestmax' : [],
\ 'foldopen' : [],
\ 'foldtext' : [],
\ 'formatexpr' : [],
\ 'formatoptions' : [],
\ 'formatlistpat' : [],
\ 'formatprg' : [],
\ 'gdefault' : [],
\ 'grepformat' : [],
\ 'grepprg' : [],
\ 'guicursor' : [],
\ 'helpfile' : [],
\ 'helpheight' : [],
\ 'helplang' : [],
\ 'hidden' : [],
\ 'highlight' : [],
\ 'history' : [],
\ 'hkmap' : [],
\ 'hkmapp' : [],
\ 'hlsearch' : [],
\ 'icon' : [],
\ 'iconstring' : [],
\ 'ignorecase' : [],
\ 'iminsert' : [],
\ 'imsearch' : [],
\ 'include' : [],
\ 'includeexpr' : [],
\ 'incsearch' : [],
\ 'indentexpr' : [],
\ 'indentkeys' : [],
\ 'infercase' : [],
\ 'insertmode' : [],
\ 'isfname' : [],
\ 'isident' : [],
\ 'iskeyword' : [],
\ 'isprint' : [],
\ 'joinspaces' : [],
\ 'key' : [],
\ 'keymap' : [],
\ 'keymodel' : [],
\ 'keywordprg' : [],
\ 'langmap' : [],
\ 'langmenu' : [],
\ 'laststatus' : [],
\ 'lazyredraw' : [],
\ 'linebreak' : [],
\ 'lines' : [],
\ 'lisp' : [],
\ 'lispwords' : [],
\ 'list' : [],
\ 'listchars' : [],
\ 'loadplugins' : [],
\ 'magic' : [],
\ 'makeef' : [],
\ 'makeprg' : [],
\ 'matchpairs' : [],
\ 'matchtime' : [],
\ 'maxcombine' : [],
\ 'maxfuncdepth' : [],
\ 'maxmapdepth' : [],
\ 'maxmem' : [],
\ 'maxmempattern' : [],
\ 'maxmemtot' : [],
\ 'menuitems' : [],
\ 'migemo' : [],
\ 'migemodict' : [],
\ 'mkspellmem' : [],
\ 'modeline' : [],
\ 'modelines' : [],
\ 'modifiable' : [],
\ 'modified' : [],
\ 'more' : [],
\ 'mouse' : [],
\ 'mousemodel' : [],
\ 'mousetime' : [],
\ 'nrformats' : [],
\ 'number' : [],
\ 'numberwidth' : [],
\ 'omnifunc' : [],
\ 'opendevice' : [],
\ 'operatorfunc' : [],
\ 'paragraphs' : [],
\ 'paste' : [],
\ 'pastetoggle' : [],
\ 'patchexpr' : [],
\ 'patchmode' : [],
\ 'path' : [],
\ 'preserveindent' : [],
\ 'previewheight' : [],
\ 'previewwindow' : [],
\ 'printdevice' : [],
\ 'printfont' : [],
\ 'printheader' : [],
\ 'printoptions' : [],
\ 'prompt' : [],
\ 'pumheight' : [],
\ 'quoteescape' : [],
\ 'readonly' : [],
\ 'redrawtime' : [],
\ 'regexpengine' : [],
\ 'relativenumber' : [],
\ 'remap' : [],
\ 'report' : [],
\ 'restorescreen' : [],
\ 'revins' : [],
\ 'rightleft' : [],
\ 'rightleftcmd' : [],
\ 'ruler' : [],
\ 'rulerformat' : [],
\ 'runtimepath' : [],
\ 'scroll' : [],
\ 'scrollbind' : [],
\ 'scrolljump' : [],
\ 'scrolloff' : [],
\ 'scrollopt' : [],
\ 'sections' : [],
\ 'secure' : [],
\ 'selection' : [],
\ 'selectmode' : [],
\ 'sessionoptions' : [],
\ 'shell' : [],
\ 'shellcmdflag' : [],
\ 'shellpipe' : [],
\ 'shellquote' : [],
\ 'shellredir' : [],
\ 'shellslash' : [],
\ 'shelltemp' : [],
\ 'shellxquote' : [],
\ 'shellxescape' : [],
\ 'shiftround' : [],
\ 'shiftwidth' : [],
\ 'shortmess' : [],
\ 'shortname' : [],
\ 'showbreak' : [],
\ 'showcmd' : [],
\ 'showfulltag' : [],
\ 'showmatch' : [],
\ 'showmode' : [],
\ 'showtabline' : [],
\ 'sidescroll' : [],
\ 'sidescrolloff' : [],
\ 'smartcase' : [],
\ 'smartindent' : [],
\ 'smarttab' : [],
\ 'softtabstop' : [],
\ 'spell' : [],
\ 'spellcapcheck' : [],
\ 'spellfile' : [],
\ 'spelllang' : [],
\ 'spellsuggest' : [],
\ 'splitbelow' : [],
\ 'splitright' : [],
\ 'startofline' : [],
\ 'statusline' : [],
\ 'suffixes' : [],
\ 'suffixesadd' : [],
\ 'swapfile' : [],
\ 'swapsync' : [],
\ 'switchbuf' : [],
\ 'synmaxcol' : [],
\ 'syntax' : [],
\ 'tabline' : [],
\ 'tabpagemax' : [],
\ 'tabstop' : [],
\ 'tagbsearch' : [],
\ 'taglength' : [],
\ 'tagrelative' : [],
\ 'tags' : [],
\ 'tagstack' : [],
\ 'term' : [],
\ 'termbidi' : [],
\ 'termencoding' : [],
\ 'terse' : [],
\ 'textauto' : [],
\ 'textmode' : [],
\ 'textwidth' : [],
\ 'thesaurus' : [],
\ 'tildeop' : [],
\ 'timeout' : [],
\ 'timeoutlen' : [],
\ 'title' : [],
\ 'titlelen' : [],
\ 'titleold' : [],
\ 'titlestring' : [],
\ 'ttimeout' : [],
\ 'ttimeoutlen' : [],
\ 'ttybuiltin' : [],
\ 'ttyfast' : [],
\ 'ttyscroll' : [],
\ 'ttytype' : [],
\ 'undodir' : [],
\ 'undofile' : [],
\ 'undolevels' : [],
\ 'undoreload' : [],
\ 'updatecount' : [],
\ 'updatetime' : [],
\ 'verbose' : [],
\ 'verbosefile' : [],
\ 'viewdir' : [],
\ 'viewoptions' : [],
\ 'viminfo' : [],
\ 'virtualedit' : [],
\ 'visualbell' : [],
\ 'warn' : [],
\ 'weirdinvert' : [],
\ 'whichwrap' : [],
\ 'wildchar' : [],
\ 'wildcharm' : [],
\ 'wildignore' : [],
\ 'wildignorecase' : [],
\ 'wildmenu' : [],
\ 'wildmode' : [],
\ 'wildoptions' : [],
\ 'window' : [],
\ 'winheight' : [],
\ 'winfixheight' : [],
\ 'winfixwidth' : [],
\ 'winminheight' : [],
\ 'winminwidth' : [],
\ 'winwidth' : [],
\ 'wrap' : [],
\ 'wrapmargin' : [],
\ 'wrapscan' : [],
\ 'write' : [],
\ 'writeany' : [],
\ 'writebackup' : [],
\ 'writedelay' : [],
\ }



function! s:null(...)
  return []
endfunction

let s:complete = {
\ 'command' : function('s:command_complete'),
\ 'function' : function('s:function_complete'),
\ 'augroup' : function('s:augroup_complete'),
\ 'buffer' : function('s:buffer_complete'),
\ 'option' : function('s:option_complete'),
\ 'buffer_word' : function('s:buffer_word_complete'),
\ 'null' : function('s:null'),
\ }

function! ccline#complete#finish()
  unlet! s:user_command
  unlet! s:user_function
  unlet! s:buffer_word
endfunction
