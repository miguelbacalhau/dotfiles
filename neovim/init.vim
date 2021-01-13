set nocompatible              " be iMproved, required
filetype plugin indent on
syntax on

" ================
" === Plugings ===
" ================
packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" === leader
let mapleader=" "

" === Colorscheme
call minpac#add('rakr/vim-one', {'type': 'opt'})

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
call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
call minpac#add('junegunn/fzf.vim')
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files -g "!.git"'
let g:fzf_layout = { 'down': '~30%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --ignore-case -g "!package-lock.json" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :BLines<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)

" === PHP
call minpac#add('StanAngeloff/php.vim')
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

" === Javascript
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')

" === typescript
call minpac#add('HerringtonDarkholme/yats.vim')

" === coc intellisense
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
let g:coc_global_extensions = [
      \'coc-tsserver',
      \'coc-css',
      \'coc-eslint',
      \'coc-json',
      \'coc-prettier',
      \'coc-yaml'
      \]
inoremap <silent><expr> <c-x><c-o> coc#refresh()
nmap <leader>d  <Plug>(coc-definition)
nmap <leader>r  <Plug>(coc-references)
nmap <leader>y  <Plug>(coc-format)
nmap <leader>a  <Plug>(coc-diagnostic-next)
nmap <leader>i  <Plug>(coc-fix-current)
nmap <leader>cr <Plug>(coc-refactor)
nmap <leader>ca <Plug>(coc-codeaction)
vmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>e  :<C-u>CocList diagnostics<cr>
nmap <leader>h  :call CocAction('doHover')<cr>
command! -nargs=0 OrganizeImport :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=? Fold :call CocAction('fold', 'region')

augroup formatonSave
  autocmd!
  autocmd FileType typescript,typescriptreact,json
    \ autocmd BufWritePre <buffer> silent call CocAction('format')
augroup END

" === less
call minpac#add('groenewege/vim-less')

" === styled components
call minpac#add('styled-components/vim-styled-components')

" === editorconfig formatting
call minpac#add('sgur/vim-editorconfig')

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
" === remove hightlight and close lists on ESC
noremap <esc> :noh<bar>:ccl<bar>:lcl<return><esc>

" ===============
" === Configs ===
" ===============
" === colorscheme
colorscheme one
set background=dark
 hi default link CocErrorSign ALEErrorSign
 hi default link CocWarningSign ALEWarningSign

" === true colors support
set termguicolors
" === completion
set completeopt=longest,menuone
" === I beam in insert mode
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
set shiftwidth=2
set tabstop=2
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
" === sign column always on
set signcolumn=yes
