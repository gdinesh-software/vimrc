filetype plugin on
set nocompatible
set noundofile
set undodir=~\.config\undodir\
set noundofile
set noswapfile
set nobackup
set nu rnu
set backspace=eol,indent,start
set incsearch
set nohls
set ruler
set noshowmode
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set smartindent
set cot=menuone,noselect shm+=c
set scrolloff=10
set laststatus=2
set cmdheight=2
set showcmd
set guicursor=n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
set guifont="Cascadia Code Semibold"
set updatetime=50
set nowrap
set splitright
set splitbelow
set list
set scrolloff=10
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set t_Co=256

call plug#begin('~\.config\nvim\plugged\')
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'vimwiki/vimwiki'
    Plug 'itchyny/lightline.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'cocopon/iceberg.vim'
    Plug 'TheRealKizu/kizu.vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
call plug#end()

inoremap jj <Esc>

let mapleader = " "

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>sv :so ~\_vimrc<CR>
nnoremap <leader>ev :find ~\_vimrc<CR>
nnoremap <leader>et :find ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json<CR>
nnoremap <leader>pu :PlugUpgrade<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <silent> <leader>on :Vex<CR>:vertical resize 30<CR>
nnoremap <silent> <leader>rp :vertical resize 125<CR>
nnoremap <silent> <leader>xc :!clang % && a.exe<CR>
nnoremap <leader>xp :!cls && python %<CR> 
nnoremap <leader>xl :!cls && clisp %<CR>
nnoremap <leader>xr :!cls && rustc %<CR>
nnoremap <leader>cr :RustTest!<CR>
nnoremap <leader>out :!%<<CR>
nnoremap <leader>tl :tabnew<CR>:term<CR>iclisp<CR>
nnoremap <leader>dl :!sbcl --load %<CR>
nnoremap <leader>rb <C-^>
nnoremap <leader>p "+p<CR>
nnoremap <leader>y ggVG"+y<CR>
nnoremap <silent> <leader>bb :buffers<CR>
nnoremap <silent> <leader>bj :bn<CR>
nnoremap <silent> <leader>bk :bp<CR>
nnoremap <silent> <leader>bd :bw<CR>
nnoremap <silent> <leader>bD :bw!<CR>
nnoremap <Up> <NUL>
nnoremap <Right> <NUL> 
nnoremap <Left> <NUL>
nnoremap <Down> <NUL>
inoremap <Up> <NUL>
inoremap <Right> <NUL>
inoremap <Left> <NUL>
inoremap <Down> <NUL>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <C-l> :cnext<CR>
nnoremap <C-h> :cprev<CR>
nnoremap H 0
nnoremap L $

let g:nord_bold_vertical_split_line=1
let g:nord_bold=1
let g:nord_italic=1
let g:nord_italic_comments=1
colorscheme nord
set termguicolors

highlight ColorColumn ctermbg=7 guibg=grey
set colorcolumn=80
set bg=dark
let g:lightline = {'colorscheme': 'iceberg'}

if has('nvim')
    tnoremap jj <C-\><C-n>
endif

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
    local opts = {noremap=true, silent=true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = { 'clangd', 'jedi_language_server', 'rls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
  require 'nvim-treesitter.install'.compilers = {'clang'}
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
  }
EOF
command! Format execute 'lua vim.lsp.buf.formatting()'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"NETRW FOR NERDTREE
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
