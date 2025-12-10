vim9script  
# ^  Allow ourselves to use # for comments instead of "
runtime defaults.vim  # Maintain the default behavior of remembering cursor position

# Apparently this is what I need to remember cursor position?
#au BufReadPost *
#    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
#        \ execute("normal `\"") |
#    \ endif

set mouse=a  # for mouse mode in split window
set number  # show line numbers

# wildmenu provides a pleasant autocomplete for vim commands
set wildmenu
set wildmode=longest:full,full

set nocompatible # required by polyglot ?

call plug#begin()
#Plug 'puremourning/vimspector'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
# Plug 'airblade/vim-gitgutter'
# Plug 'nbelakovski/vim-gittabs'
#Plug 'itchyny/lightline.vim'
#Plug 'vimpostor/vim-tpipeline'
if has('nvim')
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
endif
call plug#end() 

# https://github.com/microsoft/vscode/issues/249144#issuecomment-2893214779
autocmd VimEnter * set background=dark

# Ignore case in command line mode
# extracted from [https://goo.gl/vCTYdK](https://goo.gl/vCTYdK)
if exists("##CmdLineEnter")
	augroup dynamic\_smartcase
		autocmd!
		autocmd CmdLineEnter : set ignorecase
		autocmd CmdLineLeave : set noignorecase
	augroup END
endif

set colorcolumn=120
set laststatus=0  # I don't find any useful info on the statusline
set showtabline=2  # Kind of nice to always see the current filename and its modified status at the top
set ruler  # This ensures that line number and column number are always shown in cmdline area

## Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>


set termguicolors # for dracula
set term=xterm
colorscheme dracula 

g:mapleader = " "
set showcmd  # So that we can see the leader key


map <leader>r :source ~/.vimrc<CR>
map <leader>R :source ~/.vimrc <Bar> PlugInstall<CR>

# Map leader + arrows to move around panes
map <leader><Left> <C-w><Left>
map <leader><Right> <C-w><Right>
map <leader><Up> <C-w><Up>
map <leader><Down> <C-w><Down>

set splitbelow
set splitright
# Use the | key to split vertically, without the shift
map <leader>\ :vs<CR>
# Use the - key to split horizontally
map <leader>- :sp<CR>

# Close all panes in current tab
map <leader>w :tabclose<CR>

# Temporary mapping to play with tabline
map <leader>t :set tabline=<CR>
map <leader>y :set tabline=%!MyTabLine()<CR>

