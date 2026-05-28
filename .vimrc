

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

filetype plugin indent on
syntax enable

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
command! EditNvimConfig edit ~/.config/nvim/init.lua
command! EditVimConfig edit ~/.vimrc


""""""""""""""""""""""""""""""
" Custom mappings
""""""""""""""""""""""""""""""

map <F9> gT
map <F10> gt
map <F8> :q<CR>

imap fj <Esc>
imap jf <Esc>
imap jj <Esc>


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
" For windows?
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
" For linux?
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>
nnoremap <M-h> <C-W><C-H>

" For jumping around in insert mode with alt keys
tnoremap <M-j> <C-\><C-n><C-W><C-J>
tnoremap <M-k> <C-\><C-n><C-W><C-K>
tnoremap <M-l> <C-\><C-n><C-W><C-L>
tnoremap <M-h> <C-\><C-n><C-W><C-H>

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

" Move back a word with Alt-b
cnoremap <A-b> <S-Left>

" Move forward a word with Alt-f
cnoremap <A-f> <S-Right>


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


" Automatically enter terminal mode when switching to a terminal buffer
augroup TerminalAutoInsert
  autocmd!
  autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif
augroup END


" Map Control-Space in insert mode to create a new line below the current line and enter insert mode
"inoremap <C-Space> <Esc>O
"nnoremap <C-Space> <Esc>O<Esc>

" highlight Cursor guifg=white guibg=black
" highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect


" Set the highlight duration (in milliseconds)
let g:highlightedyank_highlight_duration = 300

" Customize the highlight color
highlight HighlightedyankRegion cterm=NONE ctermbg=yellow ctermfg=black guibg=yellow guifg=black

nmap <leader>tn :tabnew<CR>

set colorcolumn=79
set wrap
set linebreak

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        vertical copen
	wincmd L   " Move the quickfix window to the far right
	vertical resize 40   " Set width to 40 columns (adjust as needed)


    else
        cclose
    endif
endfunction

nnoremap <silent> <F4> :call ToggleQuickFix()<cr>

set makeprg=flake8
set errorformat=%f:%l:%c:\ %m
nnoremap cn :cnext<cr>
nnoremap cm :make<cr>
nnoremap cp :cprev<cr>
tnoremap <Esc> <C-\><C-n>
" colorscheme default

function! ToggleBackground()
    if &background == 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction
nnoremap <leader>b :call ToggleBackground()<CR>
" critical fix: prevents vimwiki from hijacking markdown


function! CopyFilePath()
  let l:path = expand('%:p')

  if has('clipboard')
    let @+ = l:path
  else
    call system('xclip -selection clipboard', l:path)
  endif

  echo "Copied file path: " . l:path
endfunction

function! CopyRangeWithContext() range abort
  let l:file = expand('%:p')
  let l:start = a:firstline
  let l:end = a:lastline
  let l:lines = getline(l:start, l:end)

  let l:content = l:file . ":" . l:start . "-" . l:end . "\n"

  if has('clipboard')
    let @+ = l:content
  else
    " echo l:content
    " call system('xclip -selection clipboard -in', l:content)
    call system('printf "%s" ' . shellescape(l:content) . ' | xclip -selection clipboard')
  endif

  echo "Copied range " . l:start . "-" . l:end
endfunction

xnoremap <leader>y :<C-u>'<,'>call CopyRangeWithContext()<CR>
command! CopyFilePath call CopyFilePath()

nmap <leader>yf :CopyFilePath<CR>
