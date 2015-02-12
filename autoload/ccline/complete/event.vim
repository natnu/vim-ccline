function! ccline#complete#event#complete(A, L, P)
  return ccline#complete#forward_matcher(s:autocmd_events, a:A)
endfunction

let s:autocmd_events = [
\ BufAdd,
\ BufCreate,
\ BufDelete,
\ BufEnter,
\ BufFilePost,
\ BufFilePre,
\ BufHidden,
\ BufLeave,
\ BufNew,
\ BufNewFile,
\ BufRead,
\ BufReadCmd,
\ BufReadPost,
\ BufReadPre,
\ BufUnload,
\ BufWinEnter,
\ BufWinLeave,
\ BufWipeout,
\ BufWrite,
\ BufWriteCmd,
\ BufWritePost,
\ BufWritePre,
\ CmdwinEnter,
\ CmdwinLeave,
\ ColorScheme,
\ CompleteDone,
\ CursorHold,
\ CursorHoldI,
\ CursorMoved,
\ CursorMovedI,
\ EncodingChanged,
\ FileAppendCmd,
\ FileAppendPost,
\ FileAppendPre,
\ FileChangedRO,
\ FileChangedShell,
\ FileChangedShellPost,
\ FileReadCmd,
\ FileReadPost,
\ FileReadPre,
\ FileType,
\ FileWriteCmd,
\ FileWritePost,
\ FileWritePre,
\ FilterReadPost,
\ FilterReadPre,
\ FilterWritePost,
\ FilterWritePre,
\ FocusGained,
\ FocusLost,
\ FuncUndefined,
\ GUIEnter,
\ GUIFailed,
\ InsertChange,
\ InsertCharPre,
\ InsertEnter,
\ InsertLeave,
\ MenuPopup,
\ QuickFixCmdPost,
\ QuickFixCmdPre,
\ QuitPre,
\ RemoteReply,
\ SessionLoadPost,
\ ShellCmdPost,
\ ShellFilterPost,
\ SourceCmd,
\ SourcePre,
\ SpellFileMissing,
\ StdinReadPost,
\ StdinReadPre,
\ SwapExists,
\ Syntax,
\ TabEnter,
\ TabLeave,
\ TermChanged,
\ TermResponse,
\ TextChanged,
\ TextChangedI,
\ User,
\ VimEnter,
\ VimLeave,
\ VimLeavePre,
\ VimResized,
\ WinEnter,
\ WinLeave,
\ ]