set nobackup
set noswapfile

set encoding=utf-8
set fileformats=unix,dos
set backspace=start,eol,indent

silent! language en_US.UTF-8
set clipboard+=unnamedplus
set expandtab

set cursorline
set nowrap
set number
set ruler
set cindent
set autoindent
set shiftwidth=4
set tabstop=4
set showtabline=2

set list
set listchars=tab:>_,trail:_
set shortmess=I

set mouse=a
set mousemodel=extend
set visualbell t_vb=

" Statusline
set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=|
set statusline+=\ 
set statusline+=%f
set statusline+=%=
set statusline+=%l:%c\[%P\]\ \ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}\ \ 
set statusline+=%{&ff}\ \ 
set statusline+=%y
set noshowmode

" Autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Copy and paste shortcut
vmap <C-c> "+y
vmap <C-S-x> "+c
vmap <C-S-v> c<ESC>"+p
vmap <C-S-v> <C-r><C-o>+

" Theme
set termguicolors
silent! colorscheme tokyonight
silent! highlight TabLineSel guibg=#f7768e

" Filetype settings
autocmd BufRead,BufEnter *.txt set wrap
autocmd BufRead,BufEnter *.txt set linebreak
autocmd BufRead,BufEnter *.txt set noautoindent
autocmd BufRead,BufEnter *.txt set nocindent
autocmd BufRead,BufEnter * if &filetype == "" | set wrap | endif
autocmd BufRead,BufEnter * if &filetype == "" | set linebreak | endif
autocmd BufRead,BufEnter * if &filetype == "" | set noautoindent | endif
autocmd BufRead,BufEnter * if &filetype == "" | set nocindent | endif

autocmd BufRead,BufEnter *.ps1 set ff=dos

" Mode
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        return "NORMAL"
    elseif l:mode==?"v"
        return "VISUAL"
    elseif l:mode==#"i"
        return "INSERT"
    elseif l:mode==#"R"
        return "REPLACE"
    elseif l:mode==?"s"
        return "SELECT"
    elseif l:mode==#"t"
        return "TERMINAL"
    elseif l:mode==#"c"
        return "COMMAND"
    elseif l:mode==#"!"
        return "SHELL"
    endif
endfunction

