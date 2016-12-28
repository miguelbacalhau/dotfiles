set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" vim usability plugins
Plugin 'zhaocai/GoldenView.Vim'
Plugin 'scrooloose/nerdtree'
Plugin 'taiansu/nerdtree-ag'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-startify'
Plugin 'vim-scripts/AfterColors.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'kiddos/malokai.vim'

" tools plugins
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'Shougo/vimproc.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'Valloric/YouCompleteMe'

" programming languages plugins
Plugin 'StanAngeloff/php.vim'
Plugin 'm2mdas/phpcomplete-extended'
Plugin 'joonty/vim-phpqa'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'groenewege/vim-less'
Plugin 'evidens/vim-twig'
Plugin 'stephpy/vim-yaml'

call vundle#end()
filetype plugin indent on

" === startify
set viminfo='100,n$HOME/.vim/files/info/viminfo
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
let g:airline_theme='distinguished'

" === easymotion
let g:EasyMotion_leader_key = '`'
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_smartcase = 1

" === phpqa
let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_args = "--standard=psr2"

" == CtrlP ==
nmap <C-Tab> :CtrlPBuffer<CR>
nmap <C-u> :CtrlPMRU<CR>

"== Ctrl funky
nnoremap <C-f> :CtrlPFunky<Cr>

" === phpcomplete
let g:phpcomplete_index_composer_command = 'composer'
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
set completeopt=longest,menuone

" === arrow keys alt + ijkl
nnoremap <M-i> <UP>
inoremap <M-i> <UP>
nnoremap <M-j> <LEFT>
inoremap <M-j> <LEFT>
nnoremap <M-k> <DOWN>
inoremap <M-k> <DOWN>
nnoremap <M-l> <RIGHT>
inoremap <M-l> <RIGHT>

" === home and end keys on alt + hn
nnoremap <M-h> <HOME>
inoremap <M-h> <HOME>
nnoremap <M-n> <END>
inoremap <M-n> <END>

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

"=== help my plox (credits to http://vimsheet.com) ~/.vim/help/AGreatVimCheatSheet.html
:map <silent> <F2> :silent !google-chrome --app="file:///home/miguel/.vim/help/AGreatVimCheatSheet.html" && sleep 0.5 && wmctrl -a "A Great Vim Cheat Sheet" -b add,above &<CR>

" === ColorScheme
colorscheme molokai

" === GUI View Settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"=== other
set history=700
set so=7
set number
set wildmenu
set wildignore=*~
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
syntax enable
set encoding=utf8
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set nowrap
set paste