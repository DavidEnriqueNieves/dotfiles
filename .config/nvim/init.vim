
imap jj <Esc>
imap fj <Esc>
imap jf <Esc>

call plug#begin()

" Declare the list of plugins.

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'SirVer/ultisnips'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier',  'coc-snippets']  " list of CoC extensions needed

Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'f-person/git-blame.nvim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'dylanaraps/wal'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" let g:UltiSnipsExpandTrigger = "<nop>"
"     let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsSnippetDirectories = ["mysnippets"]
let g:UltiSnipsSnippetsDir = "mysnippets"
imap <TAB> <Plug>(coc-snippets-expand)
"
colorscheme wal
set background=dark


let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0



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
nnoremap # #zzmap map map


inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction


" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:airline#extensions#tabline#enabled = 1

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



map <F9> gT
map <F10> gt

setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
