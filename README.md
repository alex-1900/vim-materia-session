# Materia Session
Vim/Neovim session manager from [Materia](https://github.com/speed-sonic/vim-materia).

## Installation
using a Vim plug-in manager

### Using Plug
```vim
call plug#begin('~/.vim/plugged')
Plug 'speed-sonic/vim-materia-session'
call plug#end()
```

### Using Plug
```vim
call dein#begin('~/.cache/dein')
call dein#add('speed-sonic/vim-materia-session')
call dein#end()
```

## Options
plug-in options:

| Option | Comment | Default |
| -------- | ------ | ------ |
| `g:meteria_session_mode` | There are two types: 1) `file`: Save the session file in the current directory, default file name is `Session.vim`.  2) `dir` (default): Save the session file in a specific directory, default is `~/.meteria_session`. the session file name is Formatted current directory path. | `Session.vim` |
| `g:materia_session_directory` | Set the storage directory in `dir` mode | `~/.meteria_session` |
| `g:materia_session_filename` | Set the session filename in `file` mode | `Session.vim` |
| `g:session_autosave_on_actions` | Set to `1` or `0` to enable/disable autosave features after the plugin loaded | `0` |

## Commands
Note that You should set `sessionoptions` in your `.vimrc` or `init.vim`(neovim). Usually, we disable the `options` parameter.
```vim
set sessionoptions-=options
```

- `:MeteriaSessionSave`: This command will call the `:mksession` and saves your current session or create a new session by the `g:meteria_session_mode`.

- `:MeteriaSessionLoad`: This command will load the current session based on the `g:meteria_session_mode` variable.

- `:MeteriaSessionAutosaveEnable`: This command will enable the autosave feature on buffers changed

- `:MeteriaSessionAutosaveDisable`: This command will disable the "auto save on buffer changes" feature.

- `:MeteriaSessionAutosaveDisable`: This command will switch between the `:MeteriaSessionAutosaveEnable` and `:MeteriaSessionAutosaveDisable`
