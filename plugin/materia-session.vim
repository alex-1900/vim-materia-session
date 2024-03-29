"=============================================================================
" FILE: materia-session.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

if exists("g:loaded_materia_session") || v:version < 700 || &cp
  finish
endif
let g:loaded_materia_session = 1

" session mode: `file` or `dir`
let g:materia_session_mode = get(g:, 'materia_session_mode', 'dir')
let g:materia_session_directory = get(g:, 'materia_session_directory', $HOME . '/.materia_session')
let g:materia_session_filename = get(g:, 'materia_session_filename', 'Session.vim')
let g:session_autosave_on_actions = get(g:, 'session_autosave_on_actions', 0)

command! -nargs=? MateriaSessionLoad call MateriaSessionLoad(<f-args>)
command! -nargs=? MateriaSessionSave call MateriaSessionSave(<f-args>)
command! MateriaSessionToggleAutosave :let g:session_autosave_on_actions = 1 - g:session_autosave_on_actions
command! MateriaSessionAutosaveEnable :let g:session_autosave_on_actions = 1
command! MateriaSessionAutosaveDisable :let g:session_autosave_on_actions = 0

function! MateriaSessionLoad(...)
  if filereadable(s:load_this_session(get(a:, 1, 0)))
    execute 'source' fnameescape(v:this_session)
  endif
  if exists('#User#MateriaSessionLoaded')
    doautocmd <nomodeline> User MateriaSessionLoaded
  endif
endfunction

function! MateriaSessionSave(...)
  if s:frequency_lock(1)
    if g:materia_session_mode ==# 'dir' && !isdirectory(g:materia_session_directory)
      call mkdir(g:materia_session_directory, 'p')
    endif
    if s:load_this_session(get(a:, 1, 0)) != ''
      execute 'mksession! '. fnameescape(v:this_session)
    endif
  endif
endfunction

" auto save on actions
augroup MateriaSessionAutosave
  autocmd! BufLeave,FocusLost,InsertLeave * if g:session_autosave_on_actions
    \| call MateriaSessionSave()
    \| endif
augroup END


function! s:load_this_session(filename)
  let l:session = a:filename ? a:filename : v:this_session
  if l:session == ''
    let l:cwd = getcwd()
    let l:session = g:materia_session_mode ==# 'dir' ?
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
