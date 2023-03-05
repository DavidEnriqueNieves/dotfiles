
set nocompatible              
filetype off                  


"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'sheerun/vim-polyglot'
"Plugin 'preservim/nerdcommenter'
"" plugin on GitHub repo
"Plugin 'ycm-core/YouCompleteMe'
"call vundle#end()            " required
"filetype plugin indent on    " required
"" https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
"if &term =~ '^screen'
    "" tmux will send xterm-style keys when its xterm-keys option is on
    "execute "set <xUp>=\e[1;*A"
    "execute "set <xDown>=\e[1;*B"
    "execute "set <xRight>=\e[1;*C"
    "execute "set <xLeft>=\e[1;*D"
"endif
"" Track the engine.



imap jj <Esc>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" select recently pasted text
nnoremap gp `[v`]

imap fj <Esc>
imap jf <Esc>

" map <leader>j !jq '.'<CR>
map <leader>j :w !jq '.'<CR>



set relativenumber
set number
" set foldopen-=jump
" set foldopen-=search
" set foldopen-=mark
" set foldopen-=undo
" set foldopen-=insert



syntax on 
set ruler
set ignorecase
" highlight the search result
set hlsearch
" starts searching as you type
set incsearch

set smartcase

" dark background
set background=dark


set foldmethod=syntax

" set cursorcolumn


nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" map j gj
" map k gk