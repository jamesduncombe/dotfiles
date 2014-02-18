" Base config

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
" required!
Bundle 'gmarik/vundle'

" Bundles
Bundle 'kien/ctrlp.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'skalnik/vim-vroom'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/ctags.vim'
Bundle 'vim-scripts/tComment'

syntax enable
filetype plugin indent on     " required!

" Now we're in the fun zone...

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " See: https://github.com/slim-template/vim-slim/issues/38
  autocmd BufNewFile,BufRead *.slim set syntax=slim|set ft=slim

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END


color molokai

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
autocmd BufWritePre *.rb,*.slim,*.coffee,*.sass,*.scss,*.css,*.html,*.js :call <SID>StripTrailingWhitespaces()

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

let g:agprg = 'ag --nogroup --nocolor --column'

" Mappings

let mapleader = ","

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Index ctags from any project, including those outside Rails
map <leader>ct :!/usr/local/bin/ctags -R .<cr>

" file finders
nmap <leader>t :CtrlP<cr>
nmap <leader>e :Ex<cr>

" Use ctrl-[hjkl] to select the active split!
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap r to Ctrl + R (redo)
nmap r <c-r>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Sort out pasting
nmap <leader>p :set paste<cr>

" Sort out copying visual block
vmap <C-c> "*yy

