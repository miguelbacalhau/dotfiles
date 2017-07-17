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
Plug 'bronson/vim-trailing-whitespace'
Plug 'joshdick/onedark.vim'

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

noremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
inoremap <C-v> <nop>

" === startify
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
" startify - close session and display Startify with Ctrl-Q

" === NERDTree
nmap <C-n> :NERDTreeToggle<CR>
set laststatus=2

" GoldenView
let g:goldenview__enable_default_mapping = 0

" === Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_y=''

" Ale linter
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'

" === easymotion
let g:EasyMotion_leader_key = ';'
map <Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_smartcase = 1

" == fzf  ==
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<Cr>
nnoremap <C-f> :BLines<Cr>
nnoremap <C-h> :BTags<Cr>

" === completion
set completeopt=longest,menuone

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

" === html/javascript/typescript 2 spaces instead of 4
au FileType html setl sw=2 sts=2
au FileType javascript setl sw=2 sts=2
au FileType vue setl sw=2 sts=2
au FileType typescript setl sw=2 sts=2

" === scrolling
noremap <silent> <c-u> <ScrollWheelUp>
noremap <silent> <c-d> <ScrollWheelDown>
" noremap <silent> <c-u> 3k
" noremap <silent> <c-d> 3j

" === ColorScheme
colorscheme onedark

" === I beam in insert mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" === persistent undo
set undofile
set undodir=~/.config/nvim/undofiles

"=== other
if $COLORTERM == 'truecolor' || $TERM == 'st-256color' || $TERM == 'screen-256color'
    set termguicolors
endif
set encoding=utf8
set mouse=a
set number
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
set hidden
set dictionary=/usr/share/dict/words
set noshowcmd
set clipboard=unnamedplus

" st del key hack
map <F1> <del>
map! <F1> <del>
