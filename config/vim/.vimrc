set nocompatible
set nobackup
set noswapfile

set encoding=utf-8
set fileformats=unix
set backspace=start,eol,indent

let $LANG='en'
set clipboard=unnamed,autoselect
set clipboard=unnamedplus
set expandtab

set cursorline
set nowrap
set number
set ruler
set autoindent
set smartindent
set cindent
set shiftwidth=4
set tabstop=4
set showtabline=2
set list
set listchars=tab:>_,trail:_
set shortmess=I

set mouse=a
set visualbell t_vb=
set wildmenu

" Statusbar
set laststatus=2
set statusline=
set statusline=%F
set statusline+=%=
"set statusline+=%l:%c\ \ 
set statusline+=%l:%c\[%P\]\ \ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}\ \ 
set statusline+=%{&ff}\ \ 
set statusline+=%y

" Autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Custom shortcuts
if has("gui_running")
    vmap <C-c> "+yi
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <C-r><C-o>+
else
    vmap <C-S-c> "+yi
    vmap <C-S-x> "+c
    vmap <C-S-v> c<ESC>"+p
    imap <C-S-v> <C-r><C-o>+
endif

" Copy/Paste on wayland
if has("linux")
    xnoremap "+y y:call system("wl-copy", @")<cr>
    nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
    nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
endif

" Tokyo Night theme
set termguicolors
syntax enable
silent! colorscheme tokyonight
if has("win32")
    hi Comment ctermbg=0
endif

" gVim
if has("gui_running")
    set guioptions -=T
    set lines=28 columns=128
    silent! set guifont=JetBrains\ Mono\ NL\ 10
endif

" .txt config
autocmd BufRead,BufEnter *.txt set wrap
autocmd BufRead,BufEnter *.txt set linebreak
autocmd BufRead,BufEnter *.txt set noautoindent
autocmd BufRead,BufEnter * if &filetype == "" | set wrap | endif
autocmd BufRead,BufEnter * if &filetype == "" | set linebreak | endif
autocmd BufRead,BufEnter * if &filetype == "" | set noautoindent | endif
