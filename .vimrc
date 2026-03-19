" [[ options ]]
set nocompatible
" numbers
set number
set relativenumber
" clipboard
set clipboard=unnamed,unnamedplus " sync with system clipboard (* and + registers)
" searching
set ignorecase " make search case insensitive
set smartcase " make search case sensitive when using Capital Letters
set incsearch " show matches while typing
set hlsearch " highlight search matches
set magic " make searching magical
" indenting
set autoindent " new line has the same indentation
set smartindent " smartly increase indenting when suitable, i.e. after {
set tabstop=4 " number of spaces a tab is displayed as
set softtabstop=4 " number of spaces inserted/deleted when editing
set shiftwidth=4 " spaces used when doing shifting with >> or <<
set expandtab " convert tabs into spaces
set smarttab " insert tabstop when pressing tab
" windows
set splitright " split new windows to the right
set splitbelow " split new windows below
" scrolling
set startofline " move cursor to first non-blank character on big movements
set scrolloff=8 " number of context lines above and below when scrolling
" whitespace
set wrap " break long lines
set linebreak " move whole world to new line when wrapping instead of breaking the word in the middle
set showbreak=++ " display this at the start of wrapped lines
" command line completion
set wildmenu " enhanced : completions
set wildoptions=pum " how : completions are displayed
set wildmode=longest:full,full " on first <tab> complete to the longest common prefix and show completion menu, on second <tab> (or if no common prefix) select the first item from completion menu
" backup
set undofile
set undolevels=1000 " the number of persisted undo history
set undodir=$HOME/.local/state/vim/undo
set nobackup
set nowritebackup
set noswapfile
" errors
set noerrorbells " no beeps on error
set visualbell " flash the screen on error (instead of beep)
" other
set mouse=a " enable mouse support
set history=999 " number of remembered : commands
set termguicolors
set cursorline " highlight the line and line number of the current line for better visibility
set signcolumn=auto
set backspace=indent,eol,nostop " intuitive backspace
set diffopt+=vertical " show diffs vertically, not horizontally
set autoread " update the buffer if file changed externally (for example in vs code)

" [[ keymaps ]]
nnoremap <space> <nop>
let mapleader = " "
let maplocalleader = "\\"
inoremap <A-Bs> <C-w>
tnoremap <ESC> <C-\><C-n>
vnoremap < <gv
vnoremap > >gv
vnoremap p "_dP 

nnoremap <expr> <C-e> max([1, winheight(0) / 10]) . "\<C-e>"
nnoremap <expr> <C-y> max([1, winheight(0) / 10]) . "\<C-y>"

" [[ autocmds ]]
autocmd BufReadPost,BufNewFile *.env,*.env.* setfiletype dot
autocmd BufReadPost,BufNewFile * if &filetype !=# 'qf' && &fileencoding ==# '' | set fileencoding=utf-8 | endif
autocmd FileType help wincmd L | vertical resize 80

" [[ plugins ]]
" install Plug if not installed and install all uninstalled plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'

Plug 'catppuccin/vim', { 'as': 'catppuccin' } " colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
Plug 'junegunn/fzf.vim' " fzf
Plug 'unblevable/quick-scope' " f t F T visual
Plug 'ojroques/vim-oscyank'

call plug#end()

" plugin configs
silent! colorscheme catppuccin_mocha

nmap <leader>fh :Helptags<cr>
nmap <leader>ff :Files<cr>
nmap <leader>fc :Commands<cr>

" Automatically copy yanked text from remote Linux Vim to local (macbook) clipboard
" This uses the 'vim-oscyank' plugin to send yanked text over SSH via OSC 52.
" Only enable this on Linux systems (e.g., remote servers)
if has('unix') && system('uname -s') =~? 'linux'
  augroup OscYank
    " Clear any previous definitions in this group
    autocmd!
    " After any yank (TextYankPost), if the operator was 'y', send it via OSC 52
    autocmd TextYankPost * if v:event.operator is# 'y' |
          \ execute 'OSCYankReg "' . v:event.regname . '"' |
          \ endif
    " After any delete, if the operator was 'd', send it via OSC 52
    autocmd TextYankPost * if v:event.operator is# 'd' && v:event.regname isnot# '_' |
          \ execute 'OSCYankReg "' . v:event.regname . '"' |
          \ endif
  augroup END
endif

