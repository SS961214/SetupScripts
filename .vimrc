set encoding=utf-8
set showcmd        " Show (partial) command in status line.
set showmatch      " Show matching brackets.
set autowrite      " Automatically save before commands like :next and :make
set mouse=a        " Enable mouse usage (all modes)
set number
set title
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set list
set listchars=tab:»-,trail:-,eol:¬,extends:»,precedes:«,nbsp:%

let _curfile=expand("%:r")
if _curfile !=? "^Makefile"
    set expandtab
endif
