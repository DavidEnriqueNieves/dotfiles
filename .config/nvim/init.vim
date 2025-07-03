" This file is your init.vim, used for configuring Neovim.

" Remap keys for exiting insert mode

source ~/.vimrc


"""""""""""""""""""""""""""""""
"     Plugins
"""""""""""""""""""""""""""""""

call plug#begin()
" Declare the list of plugins.
" Snippets are separated from the engine. Add this if you want them:
Plug 'lervag/vimtex'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'chrisbra/vim-commentary'
Plug 'preservim/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'nvim-lua/plenary.nvim'
Plug 'ferrine/md-img-paste.vim' 
Plug 'vimwiki/vimwiki'
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
"     Mappings
"""""""""""""""""""""""""""""""


nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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
