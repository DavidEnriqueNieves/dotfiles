
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
set ignorecase

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

inoremap <leader>td :call InsertDate()<CR>

inoremap <expr> d4t3 InsertDate()
cabbrev d4t3 <C-R>=strftime("%Y-%m-%d")<CR>
" Ctrl-Alt-D to insert the current date
" inoremap <C-A-d> <C-R>=strftime("%Y-%m-%d")<CR>


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
	return strftime("%Y-%m-%d")
endfunction

nnoremap <leader>dn i<C-R>="## Notes " . strftime("%d/%m/%Y") . "\n\n"<CR><Esc>


" Sets the GUI cursor to be normal? 
" https://vi.stackexchange.com/questions/37074/set-cursor-to-block



"YAML frontmatter template
"---
"title: Cell Culture Experiment 42
"date: 2025-07-11
"tags:
  "- biology
  "- cell-culture
  "- experiment
"author: Alice Smith
"---
"

function! WeekStartEndDates()
  " Get current day of week: 1=Monday ... 7=Sunday
  let l:today_dow = strftime("%u", localtime())

  " Get current timestamp (seconds since epoch)
  let l:now = localtime()

  " Calculate how many days to subtract to get Monday
  let l:days_since_monday = l:today_dow - 1

  " Seconds in a day
  let l:sec_per_day = 86400

  " Timestamp for Monday (start of week)
  let l:start_ts = l:now - (l:days_since_monday * l:sec_per_day)

  " Timestamp for Sunday (end of week)
  let l:end_ts = l:start_ts + (6 * l:sec_per_day)

  " Format dates YYYY-MM-DD
  let l:start_date = strftime("%Y-%m-%d", l:start_ts)
  let l:end_date = strftime("%Y-%m-%d", l:end_ts)

  return [l:start_date, l:end_date]
endfunction


function! GetWeekNotesTitle()
  let [start, end] = WeekStartEndDates()
  let notes_title =  "Notes for week of " . start . " to " . end
  return notes_title
endfunction
