function! ccline#complete#option#complete(A, L, P)
  return ccline#complete#option(s:option, '\l\+', '[+-^]\?=\|:', '\w*', a:A, a:L, a:P)
endfunction

let s:option = {
\ 'all' : [],
\ 'termcap' : [],
\ 'aleph' : [],
\ 'arabic' : [],
\ 'arabicshape' : [],
\ 'allowrevins' : [],
\ 'altkeymap' : [],
\ 'ambiwidth' : ['single', 'double',],
\ 'autochdir' : [],
\ 'autoindent' : [],
\ 'autoread' : [],
\ 'autowrite' : [],
\ 'autowriteall' : [],
\ 'background' : ['light', 'dark'],
\ 'backspace' : ['indent', 'eol', 'start'],
\ 'backup' : [],
\ 'backupcopy' : ['yes', 'no', 'auto'],
\ 'backupdir' : [],
\ 'backupext' : [],
\ 'backupskip' : [],
\ 'balloondelay' : [],
\ 'ballooneval' : [],
\ 'balloonexpr' : [],
\ 'binary' : [],
\ 'bomb' : [],
\ 'breakat' : [],
\ 'breakindent' : [],
\ 'breakindentopt' : [],
\ 'browsedir' : ['last', 'buffer', 'current'],
\ 'bufhidden' : ['hide', 'unload', 'delete', 'wipe'],
\ 'buflisted' : [],
\ 'buftype' : ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help'],
\ 'casemap' : ['internal', 'keepascii'],
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