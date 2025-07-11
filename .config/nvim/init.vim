" This file is your init.vim, used for configuring Neovim.

" Remap keys for exiting insert mode

source ~/.vimrc


"""""""""""""""""""""""""""""""
"     Plugins
"""""""""""""""""""""""""""""""

call plug#begin()
" Declare the list of plugins.
" Snippets are separated from the engine. Add this if you want them:

" General
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
Plug 'ryanoasis/vim-devicons'

" Markdown / Vimwiki
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'preservim/vim-markdown'
Plug 'ferrine/md-img-paste.vim' 
Plug 'vimwiki/vimwiki'
Plug 'rakr/vim-one'

" LaTex
Plug 'lervag/vimtex'

" Support 
Plug 'nvim-lua/plenary.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"""""""""""""""""""""""""""""""
"     Plugin variables
"""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories = ["mysnippets"]
let g:UltiSnipsSnippetsDir = "mysnippets"

" nmap <C-Space> <Plug>VimwikiNextLink

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


let g:vim_markdown_folding_disabled = 1
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:airline#extensions#tabline#enabled = 1
"

" ------------------------------
" UltiSnips Markdown Settings
" ------------------------------
" inserts a picture into a markdown file automatically using <leader> p
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:vim_markdown_math = 1

" SUPER important for ultisnips since by default, vimwiki will associate all
" markdown files with the vimwiki file type, thus making the ultisnips
" snippets not work
let g:vimwiki_global_ext = 0

" autocmd FileType markdown let g:UltiSnipsSnippetDirectories = ["mysnippets"]

" let g:AutoPairsEnabled = 0
" autocmd FileType markdown let g:AutoPairsEnabled = 1
" 
autocmd FileType vimwiki let g:UltiSnipsSnippetDirectories = ['mysnippets']


" DO NOT CHANGE THIS OR I WILL KICK MY OWN #$%$# 
" Got the idea from https://www.reddit.com/r/vim/comments/esgog5/vimwiki_and_markdown_syntax/
" This seems to be the only option that allows for Markdown Math mode
" identification as well as proper Vimwiki usage!
autocmd BufWinEnter *.md setlocal syntax=markdown
" autocmd BufNewFile,BufRead ~/vimwiki/**/*.md set filetype=markdown.vimwiki
" autocmd FileType vimwiki set filetype=markdown.vimwiki

" autocmd FileType vimwiki syntax match VimwikiMath "\\$.*\\$"
" autocmd FileType vimwiki syntax match VimwikiMath "\\\\\(.*\\\\\)"
" autocmd FileType vimwiki syntax match VimwikiMath "\\\\\[.*\\\\\]"

"""""""""""""""""""""""""""""""
"     NERDTree
"""""""""""""""""""""""""""""""


nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""
"     Vimwiki
"""""""""""""""""""""""""""""""


let g:vimwiki_list = [
			\ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
			\ {'path': '/home/davidn/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md'}
			\ ]

" Define aliases for switching to specific wikis
command! Wiki VimwikiIndex 1
command! Notes VimwikiIndex 2
" Add more as needed, up to the number of wikis in vimwiki_list
"

" https://github.com/vimwiki/vimwiki/issues/868
" UltiSnipsAddFiletypes markdown " (1) and (2)"

let g:mkdp_echo_preview_url=1
let g:mkdp_port='8765'


"""""""""""""""""""""""""""""""
"     Coc 
"""""""""""""""""""""""""""""""

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <Tab>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

"""""""""""""""""""""""""""""""
"     Telescope
"""""""""""""""""""""""""""""""

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" Set up telescope to use ripgrep and include hidden files
lua << EOF
require('telescope').setup{
defaults = {
	vimgrep_arguments = {
		'rg',
		'--color=never',
		'--no-heading',
		'--with-filename',
		'--line-number',
		'--column',
		'--smart-case',
		'--hidden', -- Include hidden files
	},
},
pickers= {
	find_files = {
		find_command = {"rg", "--files", "--hidden", "--glob", "!.git/*" }, -- Don't include the .git directory
	},
	},
}
EOF


"""""""""""""""""""""""""""""""
"     Airline
"""""""""""""""""""""""""""""""

let g:airline_theme='one'
set background=light
colorscheme one
let g:airline_powerline_fonts=1
set directory^=$HOME/.vim/tmp
let g:one_allow_italics=1
