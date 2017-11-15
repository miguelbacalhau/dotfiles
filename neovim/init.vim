" ================
" === Plugings ===
" ================
set nocompatible              " be iMproved, required
filetype off    " required
call plug#begin('~/.config/nvim/plugged') " Directory for plugins

" === Colorscheme
Plug 'joshdick/onedark.vim'

" === git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" === helpfull commands
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-peekaboo'

" === NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
nmap <silent> <C-n> :NERDTreeToggle<CR>
set laststatus=2

" === sneak motion
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
hi! link Sneak Search

" === Airline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_y=''

" === startify
Plug 'mhinz/vim-startify'
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0

" === fzf
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :BLines<CR>

" === Ale linter
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" === PHP
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'php-vim/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" === go-vim
Plug 'fatih/vim-go', { 'for': 'go' }
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" === Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" === less
Plug 'groenewege/vim-less' , { 'for': 'less' }

" === twig
Plug 'lumiliet/vim-twig' " twig file type not working

" === YML & RAML
Plug 'stephpy/vim-yaml', { 'for': 'yml' }
Plug 'IN3D/vim-raml', { 'for': 'raml' }

call plug#end()

" ================
" === Mappings ===
" ================
" === indent file
map <C-y> mzgg=G`z

" ===============
" === Configs ===
" ===============
" === colorscheme
colorscheme onedark
" === true colors support
set termguicolors
" === completion
set completeopt=longest,menuone
" === I beam in insert mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" === persistent undo
set undofile
set undodir=~/.config/nvim/undofiles
" === UTF8 encoding
set encoding=utf8
" === terminal mouse support
set mouse=a
" === line numbers
set number
" === wildemenu
set wildmenu
set wildignore=*~
" === search
set ignorecase
set smartcase
set incsearch
set showmatch
set mat=2
" === error bells
set noerrorbells
set novisualbell
set t_vb=
" === command timeout
set tm=500
" === no backup files
set nobackup
set nowb
set noswapfile
" === indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
" === do not wrap files when they don't fit the screen
set nowrap
" === unsaved buffers
set hidden
" === english dictionary
set dictionary=/usr/share/dict/words
" == no show commands
set noshowcmd
" === use system clipboard
set clipboard=unnamedplus
" === windows equal size
set equalalways
