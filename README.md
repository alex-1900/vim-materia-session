# Materia Session
Vim/Neovim session manager from [Materia](https://github.com/speed-sonic/vim-materia).

## Installation
using a Vim plug-in manager

### Using Plug
```vimscript
call plug#begin('~/.vim/plugged')
Plug 'speed-sonic/vim-materia-session'
call plug#end()
```

### Using Plug
```vimscript
call dein#begin('~/.cache/dein')
call dein#add('speed-sonic/vim-materia-session')
call dein#end()
```

## Options
plug-in options:

### The `g:meteria_session_mode` option
There are two types:
1. `file`: Save the session file in the current directory, default file name is `Session.vim`.

2. `dir` (default): Save the session file in a specific directory, default is `~/.meteria_session`. the session file name is Formatted current directory path.

### The `g:materia_session_directory` option
Set the storage directory in `dir` mode (default is `~/.meteria_session`)

### The `g:materia_session_filename` option
Set the session filename in `file` mode (default is `Session.vim`)

### The `g:session_autosave_on_actions` option
Set to `1` or `0` to enable/disable autosave features after the plugin loaded, default is `0` (disable).

## Commands
Note that You should set `sessionoptions` in your `.vimrc` or `init.vim`(neovim). Usually, we disable the `options` parameter.
```vim
set sessionoptions-=options
```

### The `:MeteriaSessionSave` command
This command will call the `:mksession` and saves your current session or create a new session by the `g:meteria_session_mode`.

### The `:MeteriaSessionLoad` command
This command will load the current session based on the `g:meteria_session_mode` variable.

### The `:MeteriaSessionAutosaveEnable` command
This command will enable the autosave feature on buffers changed

### The `:MeteriaSessionAutosaveDisable` command
This command will disable the "auto save on buffer changes" feature.

### The `:MeteriaSessionAutosaveDisable` command
This command will switch between the `:MeteriaSessionAutosaveEnable` and `:MeteriaSessionAutosaveDisable`
