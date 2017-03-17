set nocompatible              " be iMproved, required
filetype off                  " required

" Directory for plugins
call plug#begin('~/.config/nvim/plugged')

" vim usability plugins
Plug 'zhaocai/GoldenView.Vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'Lokaltog/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/AfterColors.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'joshdick/onedark.vim'

" tools plugins
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale', { 'for': 'php' }

" programming languages plugins
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'php-vim/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'groenewege/vim-less' , { 'for': 'less' }
Plug 'lumiliet/vim-twig'
Plug 'stephpy/vim-yaml', { 'for': 'yml' }
Plug 'SirVer/ultisnips', { 'for': 'php' }
Plug 'honza/vim-snippets', { 'for': 'php' }

call plug#end()

" === startify
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_custom_header = [
\'                 ViMeow',
\'      ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄',
\'      ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄',
\'     ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄',
\'     ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄',
\'   ▀█▒▒▒█▌▒▒█▒▒▐█▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌',
\'   ▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄',
\'   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄█▒█',
\'   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▒█▀',
\'   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀',
\'   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌',
\'    ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐',
\'    ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌',
\'     ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐',
\'      ▐▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▌',
\'       ▀▄▄▀▀▀▀▀▄▄▀▀▀▀▀▀▀▄▄▀▀▀▀▀▄▄▀',
\'',
\ ]

let g:startify_list_order = [
    \ [' MRU filearino'],
    \ 'files',
    \ [' WHERE did u find theze:'],
    \ 'dir',
    \ [' 360 noSession:'],
    \ 'sessions',
    \ [' OMG BEST FILEZ EVAH:'],
    \ 'bookmarks',
    \ ]

let g:startify_bookmarks = [ '~/.vimrc' ]
let g:startify_session_dir = '~/.vim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
" startify - close session and display Startify with Ctrl-Q
noremap <silent> <C-q> :SClose<CR>

" === NERDTree
nmap <C-n> :NERDTreeToggle<CR>
set laststatus=2

" GoldenView
let g:goldenview__enable_default_mapping = 0
nmap <silent> <Tab> <Plug>GoldenViewNext

" === Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" Ale linter
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'

" === easymotion
let g:EasyMotion_leader_key = ';'
map <Leader> <Plug>(easymotion-prefix)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_smartcase = 1

" == fzf  ==
nmap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<Cr>
nnoremap <C-f> :BLines<Cr>

" === completion
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
set completeopt=longest,menuone
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1

let g:deoplete#sources = {}
let g:deoplete#sources.php = ['buffer', 'phpcd', 'ultisnips', 'file']

" ultisnipets
let g:UltiSnipsExpandTrigger="<C-j>"

" === php-vim Configs
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" === copy paste bindings
nmap <C-V> "+gP
imap <C-V> <ESC>"+gpa
vmap <C-C> "+y

"=== auto-indentation
map <C-k> mzgg=G`z<CR>

" === ColorScheme
colorscheme onedark

" I beam in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" persistent undo
set undofile
set undodir=~/.config/nvim/undofiles

"=== other
set encoding=utf8
set termguicolors
set mouse=a
set number
set relativenumber
set wildmenu
set wildignore=*~
set ignorecase
set smartcase
set incsearch
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set nowrap
