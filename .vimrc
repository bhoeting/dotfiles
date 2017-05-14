" Make Vim more useful
set nocompatible
"2 space indents
set sts=2 sw=2
"install & configure plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugin manager
Plugin 'VundleVim/Vundle.vim'

"git integration
Plugin 'tpope/vim-fugitive'

"solarized color scheme
Plugin 'altercation/vim-colors-solarized'

"Base 16 color schemes
Plugin 'chriskempson/base16-vim'

"go plugin
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
let g:go_fmt_command = "goimports"

"syntastic
Plugin 'vim-syntastic/syntastic'
let g:syntastic_quiet_messages={'level':'warnings'}
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_go_checkers = ['golint', 'govet -unusedfuncs', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_python_pylint_rcfile='~/.pylintrc'
"let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

"ctrl-p fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'node_modules\|DS_Store\|.git\|tags'
  \ }
nmap <C-b> :CtrlPBuffer<cr>
nmap <C-m> :CtrlPTag<cr>

"sets vim working directory
"where first .git folder is found
Plugin 'airblade/vim-rooter'

"vim vinegar
Plugin 'tpope/vim-vinegar'

"Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'rcabralc/monokai-airline.vim'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'monokai'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"Latex
Plugin 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:vimtex_complete_recursive_bib = 1

"Nerdtree
Plugin 'scrooloose/nerdtree'
nmap <C-h> :NERDTreeToggle<cr>
let NERDTreeHijackNetrw = 0
nmap <F3> "zyiw:exe "Ack ".@z.""

"Vue syntax
Plugin 'posva/vim-vue'

"Javascript
Plugin 'pangloss/vim-javascript'

"JSX
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

"Project wide search
Plugin 'mileszs/ack.vim'
nmap <C-s> :Ack "@z"<cR>

":e derp/herp/merp without error!
Plugin 'pbrisbin/vim-mkdir'
"emmet
Plugin 'mattn/emmet-vim'
"multicursor
Plugin 'terryma/vim-multiple-cursors'
"monokai colorscheme
Plugin 'crusoexia/vim-monokai'
"monokai airline theme
Plugin 'rcabralc/monokai-airline.vim'

call vundle#end()
filetype plugin indent on

" Enable syntax highlighting
syntax on
set background=dark
" Use the Solarized Dark theme
colorscheme monokai
set t_Co=256

"hide vertsplit background
hi VertSplit ctermfg=black ctermbg=NONE

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set noesckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
"screen will not be redrawn when running commands that have not been typed
set lazyredraw
"remove delay when using 'O' command
set noesckeys
"use g option on search by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

"show the cursorline
set cursorline

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
"don't wrap text
set nowrap
"vertical split to the right of the current buffer
set splitright
"split under the current buffer
set splitbelow
"when K is pressed, run :help <word under cursor>
set keywordprg=:help

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
"send to background in insert mode
inoremap <C-z> <esc><C-z>
"open vimrc on ,ev
nmap <silent> <leader>ev :e ~/.vimrc<cr>
"save
nmap <leader>w :w<cr>
"clear search
nmap <leader><space> :nohlsearch<cr>
"format json
nmap <leader>j :%!python -m json.tool<cr>
"open shell command prompt quickly
nmap <leadeR>1 :!
"this mapping makes it easier to renamp ,r
nmap <leader>r :nmap <leader>r :!clear &&
"regenerate tags file
nmap <leader>y :!ctags -R .<cr>
"navigate between buffers
map fn :bn<cr>
map fp :bp<cr>
map fd :bd<cr>

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  "format c++ code on save
  autocmd BufNewFile,BufRead *.cc,*.h,*.hpp,*.cpp nmap <leader>f :%:!clang-format -style=Google %<cr>
  "start vimtex compile on ,c in latex files
  autocmd BufNewFile,BufRead *.tex nmap <leader>c :VimtexCompile<cr>
  autocmd BufNewFile,BufRead *.tex nmap <leader>x :VimtexClean<cr>
  autocmd BufNewFile,BufRead *.tex nmap <leader>e :VimtexCompileOutput<cr>
  "use ,b to run :BundleInstall and ,c to run BundleClean when in vimrc
  autocmd BufRead ~/.vimrc nmap <leader>b :BundleInstall<cr>
  autocmd BufRead ~/.vimrc nmap <leader>c :BundleClean<cr>
  "source ~/.vimrc when it is changed
  autocmd! bufWritePost ~/.vimrc source ~/.vimrc

  "file specific indentation
  "golang
  autocmd BufNewFile,BufRead *.go set sw=8 ts=8
  "C/C++
  autocmd FileType go set sw=2 sts=2
  autocmd FileType c,cpp set sw=2 sts=2
  "ruby
  autocmd FileType ruby set sw=2 sts=2
  "python
  autocmd FileType python set sw=4 sts=4
endif

"gvim stuff
if has("gui")
  "use a decent font
  set guifont=Fantasque_Sans_Mono:h17

  "why is this even highlighted at all?
  hi VertSplit guibg=NONE

  "remove left scrollbar
  set guioptions-=l
  set guioptions-=L
  "remove right scrollbar
  set guioptions-=r
  set guioptions-=R
  "remove bottom scrollbar
  set guioptions-=b

  "better line-height
  set linespace=2

  "hide vertsplit background
  hi VertSplit guibg=NONE
endif
