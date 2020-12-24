"=============================================================================
" FILE: meteria-session.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

if exists("g:loaded_meteria_session") || v:version < 700 || &cp
  finish
endif
let g:loaded_meteria_session = 1

" session mode: `file` or `dir`
let g:meteria_session_mode = get(g:, 'meteria_session_mode', 'dir')
let g:materia_session_directory = get(g:, 'materia_session_directory', $HOME . '/.meteria_session')
let g:materia_session_filename = get(g:, 'materia_session_filename', 'Session.vim')

command! -nargs=? MeteriaSessionLoad call MeteriaSessionLoad(<f-args>)
command! -nargs=? MeteriaSessionSave call MeteriaSessionSave(<f-args>)
command! MeteriaSessionToggleAutosave call MeteriaSessionToggleAutosave()
command! MeteriaSessionAutosaveEnable call MeteriaSessionAutosaveEnable()
command! MeteriaSessionAutosaveDisable call MeteriaSessionAutosaveDisable()

nnoremap <silent> <Plug>(meteria-session-load) :<C-u>call MeteriaSessionLoad()<CR>
nnoremap <silent> <Plug>(meteria-session-save) :<C-u>call MeteriaSessionSave()<CR>
nnoremap <silent> <Plug>(meteria-session-toggle-autosave) :<C-u>call MeteriaSessionToggleAutosave()<CR>
nnoremap <silent> <Plug>(meteria-session-autosave-enable) :<C-u>call MeteriaSessionAutosaveEnable()<CR>
nnoremap <silent> <Plug>(meteria-session-autosave-disable) :<C-u>call MeteriaSessionAutosaveDisable()<CR>

function! MeteriaSessionLoad(...)
  if filereadable(s:load_this_session(get(a:, 1, 0)))
    execute 'source' fnameescape(v:this_session)
  endif
endfunction

function! MeteriaSessionSave(...)
  if s:frequency_lock(1)
    if g:meteria_session_mode ==# 'dir' && !isdirectory(g:materia_session_directory)
      call mkdir(g:materia_session_directory, 'p')
    endif
    if s:load_this_session(get(a:, 1, 0)) != ''
      execute 'mksession! '. fnameescape(v:this_session)
    endif
  endif
endfunction

let s:session_autosave_on_actions = 0
function! MeteriaSessionToggleAutosave()
  if s:session_autosave_on_actions
    call MeteriaSessionAutosaveDisable()
  else
    call MeteriaSessionAutosaveEnable()
  endif
endfunction

function! MeteriaSessionAutosaveEnable()
  augroup MeteriaSessionAutosave
    autocmd! BufLeave,FocusLost,FocusGained,InsertLeave * call MeteriaSessionSave()
  augroup END
  let s:session_autosave_on_actions = 1
endfunction

function! MeteriaSessionAutosaveDisable()
  augroup! MeteriaSessionAutosave
  let s:session_autosave_on_actions = 0
endfunction


function! s:load_this_session(filename)
  let l:session = a:filename ? a:filename : v:this_session
  if l:session == ''
    let l:cwd = getcwd()
    let l:session = g:meteria_session_mode ==# 'dir' ?
      \ g:materia_session_directory . '/' . substitute(l:cwd, '[.:/\\#$-]', '_', 'g')[0:200] . '.vim' :
      \ l:cwd . '/' . g:materia_session_filename
  endif
  return s:set_this_session(l:session)
endfunction

function! s:frequency_lock(sec)
  let current_time = localtime()
  let s:last_update = get(s:, 'last_update', 0)
  if (current_time - s:last_update) >= a:sec
    let s:last_update = current_time
    checktime
    return 1
  endif
  return 0
endfunction

function! s:set_this_session(session)
  if v:this_session != a:session
    let v:this_session = a:session
  endif
  return v:this_session
endfunction
