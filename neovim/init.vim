set nocompatible              " be iMproved, required
filetype plugin indent on
syntax on

" ================
" === Plugings ===
" ================

packadd minpac
packadd onedark.vim

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" === leader
let mapleader=" "

" === Colorscheme
call minpac#add('joshdick/onedark.vim', {'type': 'opt'})

" === git
call minpac#add('tpope/vim-fugitive')
call minpac#add('airblade/vim-gitgutter')

" === helpfull commands
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')

" === NERDTree
call minpac#add('scrooloose/nerdtree')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>nn :NERDTreeToggle<CR>
nmap <silent> <leader>nf :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let NERDTreeStatusline='TREE'
set laststatus=2

" === sneak motion
call minpac#add('justinmk/vim-sneak')
let g:sneak#label = 1
hi! link Sneak Search

" === startify
call minpac#add('mhinz/vim-startify')
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0

" === fzf
call minpac#add('junegunn/fzf', { 'do': './install --bin' })
call minpac#add('junegunn/fzf.vim')
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>c :Commands<CR>
let g:fzf_layout = { 'down': '~15%' }
imap <c-x><c-k> <plug>(fzf-complete-word)

" === Ale linter
call minpac#add('w0rp/ale')
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'json': ['prettier'],
\}
nnoremap <leader>a :ALENextWrap<CR>
nnoremap <leader>y :ALEFix<CR>

" === PHP
call minpac#add('StanAngeloff/php.vim')
call minpac#add('php-vim/phpcd.vim')
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" === go-vim
call minpac#add('fatih/vim-go')
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" === language server client
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
autocmd FileType typescript set omnifunc=lsp#complete
autocmd FileType typescript.tsx set omnifunc=lsp#complete
autocmd FileType php set omnifunc=lsp#complete
nnoremap <silent> <leader>d :LspDefinition<CR>
nnoremap <silent> <leader>r :LspReferences<CR>
nnoremap <silent> <F3> :LspHover<CR>
nnoremap <silent> <F4> :LspRename<CR>
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'whitelist': ['typescript', 'typescript.tsx'],
    \ })
endif
" === Javascript
call minpac#add('pangloss/vim-javascript')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('ianks/vim-tsx')
call minpac#add('mxw/vim-jsx')

" === less
call minpac#add('groenewege/vim-less')

" === YML & RAML
call minpac#add('stephpy/vim-yaml')

" ================
" == StatusLine ==
" ================
function! RmCrtlChar(string)
    return substitute(a:string, '[[:cntrl:]]', 'V', '')
endfunction

set laststatus=2
set statusline=
set statusline+=%1*\ %-2.4{toupper(RmCrtlChar(mode()))}                 " Current mode
set statusline+=%0*\ %{fugitive#head()}                                 " Git Branch name
set statusline+=%0*\ %<%t\ %3*\ %R\ %M\ %w\                             " File+path
set statusline+=%*
set statusline+=%=                                                      " Space
set statusline+=%2*\ %3p%%\ %l:\ %c\                                    " Rownumber/total (%)

" ===============
" === Mappings ===
" ================
" === remove hightlight on ESC
nnoremap <esc> :noh<return><esc>

" ===============
" === Configs ===
" ===============
" === colorscheme
colorscheme onedark
let s:colors = onedark#GetColors()
call onedark#set_highlight("User1", { "bg": s:colors.green, "fg": s:colors.black, "gui": "bold" })
call onedark#set_highlight("User2", { "bg": s:colors.green, "fg": s:colors.black })
call onedark#set_highlight("User3", { "bg": s:colors.cursor_grey, "fg": s:colors.red })

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
" === windows equal size
set equalalways
" === update time
set updatetime=100
