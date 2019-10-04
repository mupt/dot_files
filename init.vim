" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" - To install :PlugInstall

call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }"

" For all linting concerns
Plug 'vim-syntastic/syntastic'

" Displays column at side of doc to see whats been changed
Plug 'airblade/vim-gitgutter'

" Simple wiki notebook
Plug 'vimwiki/vimwiki'

" CTRLP for fuzzy searching
Plug '~/.config/nvim/bundle/ctrlp.vim'

" SASS linting
Plug 'gcorne/vim-sass-lint'

"Language Specific Syntax Highlighting plugs
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'

" Ack
Plug 'mileszs/ack.vim'

" ElixirSense
Plug 'slashmili/alchemist.vim'

" Explore the buffer
Plug 'jlanzarotta/bufexplorer'

" Autocomplete for Elixir/JS
Plug 'Shougo/deoplete.nvim'

" Conquer of Completion / intellisense
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script,
" etc
Plug 'tpope/vim-endwise'

" camel case motion for supercharging w, b, e
Plug 'bkad/CamelCaseMotion'

" Initialize plugin system
call plug#end()

" Choose Color Scheme from /colors
colorscheme peaksea

" Default notebook spot for vim wiki
let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]

" Generic editor requirements
set tabstop=2
set expandtab
set colorcolumn=120
highlight ColorColumn ctermbg=221
syntax on
set number

" The big remap
:nnoremap <Tab>q <C-w>w

" Mouse
set mouse=a

" Copy Paste Madness
set clipboard=unnamed

" set shifwith so enter to next line has right chars
set shiftwidth=2

" Linting/Syntastic Settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Linting ES Lint
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'eslint'

" Nerd tree Settings
nmap <Tab>w :NERDTreeToggle<CR>

" NerdTree show hidden files
let NERDTreeShowHidden=1

" Never open new buffer in nerd tree - note failed with ACK
"autocmd BufEnter * if bufname('#') =~# NERD_tree_" | b# | endif


" Check if NERDTree is open or active
"function! IsNERDTreeOpen()
"  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
"
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
"function! SyncTree()
"  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"  NERDTreeFind
"   wincmd p
"   endif
" endfunction

 " Highlight currently open buffer in NERDTree
"autocmd BufEnter * call SyncTree()"

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" ctrlp Settings
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_depth = 10
let g:ctrlp_max_files = 15000
let g:ctrlp_working_path_mode = 0

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

au FocusGained,BufEnter * :silent! !

" Elixir autoformatting
autocmd BufWritePost *.ex,*.exs call FormatAndRedraw()
function FormatAndRedraw()
  silent !${PROJECT_ROOT}/monorepo/zlaverse/support/frmt.sh <afile>
  e!
  redraw!
endfunction

" Autocomplete with Depolete
let g:deoplete#enable_at_startup = 1

" Allows for pretty formatting of json
noremap <Leader>j :%!python -m json.tool<cr>

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Attempt to load FZF in vim
set rtp+=~/.fzf


" Backups/Swap Files/Undo File ------------------------------------------------- {{{
set nobackup                                      " don't make a backup before overwritting a file.
set nowritebackup                                 " and again.
set undofile                                      " persistent undo
set undoreload=10000
set directory=$HOME/.nvim/tmp/swap//               " keep swap files in one location
set undodir=$HOME/.nvim/tmp/undo//                 " undo files location
set backupdir=$HOME/.nvim/tmp/backup//             " backups location
" }}}

" Keymapping for fuzzy search
:nnoremap ,<space> :FZF<CR>

" Let camelcase motion take over e, w, b
let g:camelcasemotion_key = '<leader>'
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
