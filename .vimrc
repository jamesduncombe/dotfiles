" Base config

" for MacVim when I feel like it
set guifont=Hack:h13

set shell=/bin/sh
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set laststatus=2   " Always display the status line
set colorcolumn=85 " Add a ruler at 85 chars wide
set nobackup
set nowritebackup
set noswapfile     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Line numbers
set number
set numberwidth=5

" Hightlight the current line
set cursorline

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set nocompatible
filetype off

" Vundle stuff
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'slim-template/vim-slim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'
Plugin 'skalnik/vim-vroom'
Plugin 'ervandew/supertab'
" Plugin 'vim-scripts/ctags.vim'
Plugin 'vim-scripts/tComment'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'nimrod.vim'
Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-haml'
Plugin 'bling/vim-airline'
Plugin 'elixir-lang/vim-elixir'

syntax enable
filetype plugin indent on     " required!

" Use Molokai theme
color molokai

" Now we're in the fun zone...

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal tw=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set ft=markdown

  " See: https://github.com/slim-template/vim-slim/issues/38
  autocmd BufNewFile,BufRead *.slim set syntax=slim ft=slim

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 78 characters for Markdown
  autocmd BufRead,BufNewFile,BufReadPost *.md setlocal tw=78

  " ES6
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript

  " Golang
  autocmd BufRead,BufNewFile *.go set ts=4 sw=4 nolist

augroup END

" Remove trailing white space
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" And call the above on every save
autocmd BufWritePre *.php,*.rb,*.slim,*.coffee,*.sass,*.scss,*.css,*.haml,*.html,*.js :call <SID>StripTrailingWhitespaces()

" Ag setup

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects
  " .gitignore
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

endif

" Go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" Mappings

let mapleader = ","

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Index ctags from any project, including those outside Rails
map <leader>ct :!/usr/local/bin/ctags -R .<cr>

" file finders
nmap <leader>t :CtrlP<cr>
nmap <leader>e :Explore<cr>

" Mac OSX open command
nmap <leader>oo :!open ./<cr><cr>

nmap <leader>w :!osascript -e "tell application \"Google Chrome\" to tell the active tab of its first window" -e "reload" -e "end tell"<cr><cr>

" Use ctrl-[hjkl] to select the active split!
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" let g:agprg = 'ag --nogroup --nocolor --column'
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" configure syntastic syntax checking to check on open as well as save
"let g:syntastic_check_on_open=0

" Sort out pasting
set pastetoggle=<leader>p

" Ctrl + C for copying
vmap <C-c> "*yy

" Convert tab to 2 spaces
nmap <leader>cts :%s/\t/  /g<cr>

" The below commands from UnixPhilosopher
" See: http://blog.unixphilosopher.com/2015/02/five-weird-vim-tricks.html

" Enter command more with one keystroke
nnoremap ; :

" Start an external command with a single bang
nnoremap ! :!

" Fixing a common typo
cabbrev qw :wq
