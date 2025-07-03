
" from L3Harris

""""""""""""""""""""""""""""""
" Set configs
""""""""""""""""""""""""""""""
set number
set relativenumber

" Set the leader key to be the backslash
let mapleader = "\\"

set incsearch
set cursorline
set cursorcolumn
" sets a column next to a fold so that you can see that there is a fold
set foldcolumn=1
set foldlevel=99

set backspace=indent,eol,start
set belloff=all
set noshowmatch

filetype plugin on
syntax on

set encoding=UTF-8
set foldmethod=manual
" set fillchars+=eob:\ 
set scl=no " force the signcolumn to disappear
setlocal spell
set nocompatible

" highlight as you search
set hlsearch

" dark background
set background=dark

" highlight the search result
set hlsearch
" starts searching as you type
set incsearch

" ignores casing UNLESS you search with a lowercase character
set smartcase

set guicursor=n-v-c:ver25,i-ci:hor20,r-cr:hor20

" https://vi.stackexchange.com/questions/16037/vim-swap-file-best-practices
set undodir=~/.vim/undodir
set undofile
set noswapfile



""""""""""""""""""""""""""""""
" Custom Command configs
""""""""""""""""""""""""""""""
"
" Function to toggle both number and relative number settings for easily 
" copying and pasting
function! ToggleNumber()
	if &number || &relativenumber
		set nonumber norelativenumber
	else 
		set number relativenumber
	endif
endfunction



" God bless this command!

command! EditBashRc edit ~/.bashrc
command! EditNvimConfig edit ~/.config/nvim/init.vim
command! EditVimConfig edit ~/.vimrc


""""""""""""""""""""""""""""""
" Custom mappings
""""""""""""""""""""""""""""""

map <F9> gT
map <F10> gt
map <F8> :q<CR>

imap fj 
imap jf 
imap jj 


" Got bless this man:
" https://stackoverflow.com/questions/56052/best-way-to-insert-timestamp-in-vim
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p") . " - "<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p") . " - "<CR>

" Ctrl-Alt-D to insert the current date
inoremap <C-A-d> <C-R>=strftime("%Y-%m-%d")<CR>


" Map <leader># to toggle number and relativenumber
nnoremap <leader># :call ToggleNumber()<CR>

" For moving around windows
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>

" centers when searching or going to the next matching word
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

nnoremap <silent> <leader>gl :diffget LOCAL<CR>
nnoremap <silent> <leader>gr :diffget REMOTE<CR>
nnoremap <leader>ev :edit ~/.vimrc<CR>
nnoremap <leader>eb :edit ~/.bashrc<CR>
nnoremap <leader>en :edit ~/.config/nvim/init.vim<CR>

" select recently pasted text
nnoremap gp `[v`]

" remaps for command mode:
" Map Ctrl+P to move up in the command history
cnoremap <C-P> <Up>

" Map Ctrl+N to move down in the command history
cnoremap <C-N> <Down>

" Fix spelling by doing ctrl-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u



tnoremap fj <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap jf <C-\><C-n>

function! InsertDate()
	return "## Notes " . strftime("%d/%m/%Y") . "\n"
endfunction

nnoremap <leader>dn i<C-R>="## Notes " . strftime("%d/%m/%Y") . "\n\n"<CR><Esc>
