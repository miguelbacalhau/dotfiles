set nocompatible              " be iMproved, required
filetype off                  " required

" Directory for plugins
call plug#begin('~/.config/nvim/plugged')

" vim usability plugins
Plug 'zhaocai/GoldenView.Vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeFind' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeFind' }
Plug 'Lokaltog/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'bronson/vim-trailing-whitespace'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-peekaboo'

" tools plugins
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': ['php', 'javascript', 'go'] }

" programming languages plugins
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', {'for': 'php' }
Plug 'php-vim/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'groenewege/vim-less' , { 'for': 'less' }
Plug 'lumiliet/vim-twig' " twig file type not working
Plug 'stephpy/vim-yaml', { 'for': 'yml' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'IN3D/vim-raml', { 'for': 'raml' }

call plug#end()

" === startify
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0

" === NERDTree
nmap <C-n> :NERDTreeFind<CR>
set laststatus=2

" === GoldenView
let g:goldenview__enable_default_mapping = 0

" === Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_y=''

" === Ale linter
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" === easymotion
let g:EasyMotion_leader_key = ';'
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)

" == fzf  ==
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :BLines<CR>

" === php-vim Configs
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" === go-vim
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" === auto-indentation
map <C-y> mzgg=G`z<CR>

" === scrolling
noremap <silent> <C-u> <C-y>
noremap <silent> <C-d> <C-e>

" === change window
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" === colorscheme
colorscheme onedark

" === completion
set completeopt=longest,menuone

" === I beam in insert mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" === persistent undo
set undofile
set undodir=~/.config/nvim/undofiles

" === true colors support
set termguicolors

" === UTF8 encoding
set encoding=utf8

" === terminal mouse support
set mouse=a

" === line numbers
set number
 " === wildemenu
set wildmenu
set wildignore=*~
"
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

" === allow unsaved buffers to hide
set hidden

" === english dictionary words
set dictionary=/usr/share/dict/words

" == do not show commands as they are entered
set noshowcmd

" === use system clipboard as default register
set clipboard=unnamedplus

" st del key HACK
map <F1> <del>
map! <F1> <del>
