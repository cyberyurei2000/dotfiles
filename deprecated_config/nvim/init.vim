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
hi Status1 guifg=#222432 guibg=#2AC3DE
set laststatus=2
set statusline=
set statusline+=%#Status1#\ %{StatuslineMode()}\ %*
set statusline+=|
set statusline+=\ %f\ 
set statusline+=%= 
set statusline+=%l:%c\[%P\]\ \ 
set statusline+=%{&fileencoding?&fileencoding:&encoding}\ \ 
set statusline+=%{&ff}\ \ 
set statusline+=%y
set noshowmode

" Autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Shorcuts
if has("clipboard")
    vnoremap <C-c> "+y
    vnoremap <C-X> "+x
    vnoremap <C-V> "+gp
endif
noremap <C-A> ggVG
noremap <C-Y> <C-R>
noremap <C-Z> u

" Theme
set termguicolors
silent! colorscheme tokyonight-storm
silent! if g:colors_name=="tokyonight-storm"
    silent! highlight TabLineSel guibg=#f7768e
endif

" Filetype settings
autocmd BufRead,BufEnter *.txt set wrap
autocmd BufRead,BufEnter *.txt set linebreak
autocmd BufRead,BufEnter *.txt set noautoindent
autocmd BufRead,BufEnter *.txt set nocindent
autocmd BufRead,BufEnter *.ps1 set ff=dos

" Mode
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        hi Status1 guifg=#222432 guibg=#2AC3DE
        return "NORMAL"
    elseif l:mode==?"v"
        hi Status1 guifg=#222432 guibg=#BB9AF7
        return "VISUAL"
    elseif l:mode==#"i"
        hi Status1 guifg=#222432 guibg=#9ECE6A
        return "INSERT"
    elseif l:mode==#"R"
        hi Status1 guifg=#222432 guibg=#FF9E64
        return "REPLACE"
    elseif l:mode==?"s"
        hi Status1 guifg=#222432 guibg=#CFC9C2
        return "SELECT"
    elseif l:mode==#"t"
        hi Status1 guifg=#222432 guibg=#F7768E
        return "TERMINAL"
    elseif l:mode==#"c"
        hi Status1 guifg=#222432 guibg=#F7768E
        return "COMMAND"
    elseif l:mode==#"!"
        hi Status1 guifg=#222432 guibg=#F7768E
        return "SHELL"
    endif
endfunction

