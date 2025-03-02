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

" === colorscheme
call minpac#add('navarasu/onedark.nvim')

" === statusline
call minpac#add('hoob3rt/lualine.nvim')
lua <<EOF
  require'lualine'.setup {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = {'', ''},
      section_separators = {'', ''},
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {'filetype'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_c = {'filename'},
      lualine_x = {'location'},
    },
  }
EOF

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

" === leap motion
call minpac#add('ggandor/leap.nvim')
lua require('leap').create_default_mappings()

" === startify
call minpac#add('mhinz/vim-startify')
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_files_number = 5
let g:startify_change_to_dir = 0

" === fzf
call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
call minpac#add('ibhagwan/fzf-lua', {'branch': 'main'})
lua <<EOF
  require'fzf-lua'.setup {
    fzf_opts   = { ["--layout"] = "default", ["--marker"] = "+" },
    winopts = {
      height = 0.30,         -- window height
      width  = 1,            -- window width
      row    = 1,            -- window row position (0=top, 1=bottom)
      col    = 0,            -- window col position (0=left, 1=right)
    }
  }
EOF
nnoremap <leader>p <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>b <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>f <cmd>lua require('fzf-lua').blines()<CR>
nnoremap <leader>g <cmd>lua require('fzf-lua').grep()<CR>
nnoremap <leader>w <cmd>lua require('fzf-lua').grep_cWORD()<CR>
nnoremap <leader>k <cmd>lua require('fzf-lua').spell_suggest()<CR>

" === treesitter
call minpac#add('nvim-treesitter/nvim-treesitter')
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "css",
      "diff",
      "graphql",
      "javascript",
      "lua",
      "markdown",
      "php",
      "rust",
      "tsx",
      "typescript",
      "solidity"
    },
    highlight = {
    enable = true,
    },
  }
EOF

" === go-vim
call minpac#add('fatih/vim-go')
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1

" === coc intellisense
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
let g:coc_global_extensions = [
      \'coc-tsserver',
      \'coc-css',
      \'coc-eslint',
      \'coc-json',
      \'coc-prettier-dev',
      \'coc-yaml',
      \'coc-rust-analyzer',
      \'coc-solidity',
      \]
inoremap <silent><expr> <c-x><c-o> coc#refresh()
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

nmap <leader>d  <Plug>(coc-definition)
nmap <leader>t  <Plug>(coc-type-definition)
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

autocmd BufNewFile,BufRead *.mdx :set filetype=tsx

" === copilot
call minpac#add("github/copilot.vim")
let g:copilot_node_command = "~/.nvm/versions/node/v18.16.0/bin/node"
let g:copilot_enabled = v:false

imap <C-e> <Plug>(copilot-suggest)
imap <C-d> <Plug>(copilot-next)

call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('olimorris/codecompanion.nvim')
lua << EOF
  require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
    },
    agent = {
      adapter = 'copilot',
    },
  },
})
EOF

noremap <silent> <leader>cc <cmd>CodeCompanionChat Toggle<cr>

" === editorconfig formatting
call minpac#add('sgur/vim-editorconfig')

" ================
" === Mappings ===
" ================
" === remove hightlight and close lists on ESC
noremap <silent> <esc> :noh<bar>:ccl<bar>:lcl<return><esc>
" === save on ctrl + s
noremap <silent> <C-S> :w<CR>

" ===============
" === Configs ===
" ===============
" === colorscheme
colorscheme onedark
set background=dark
hi default link CocErrorSign
hi default link CocWarningSign

" === true colors support
set termguicolors
" === don't show mode in last line
set noshowmode
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
