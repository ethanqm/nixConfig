" case sensitive searches if capital present
set ignorecase
" mouse on
set mouse=a
" current line number
set number
" line distance
set relativenumber
" number column size
set numberwidth=2

" spaces instead of tab
set expandtab
" indent size
set shiftwidth=2
" backspace indent size
set softtabstop=2
" tab char size
set tabstop=2

" system copy/paste
set clipboard+=unnamedplus
" themed syntax highlighting
set syntax=on
" don't highlight searches
set nohlsearch
" disable linewrap
set nowrap
" keep folder clean
set noswapfile
" window split preference
set splitbelow splitright
" disable auto comment next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" autocomplete settings
set wildmode=longest,list,full
" display invisible characters | see BINDS
set listchars=tab:>-,space:·,nbsp:␣,trail:•,eol:$,precedes:«,extends:»

" transparent background
highlight Normal guibg=NONE
highlight NonText  guibg=NONE
highlight Normal ctermbg=none
highlight NonText ctermbg=none
"BINDS
nnoremap <space> <Nop>
let mapleader=" "
" toggle invisible characters
nnoremap <silent> <leader>s :setlocal list!<cr>
"SANSKRIT BINDS
inoremap <C-k>.l ḷ
inoremap <C-k>.r ṛ
inoremap <C-k>.m ṃ
inoremap <C-k>.n ṇ
inoremap <C-k>.s ṣ
inoremap <C-k>.t ṭ
inoremap <C-k>.d ḍ
inoremap <C-k>.h ḥ

inoremap <C-k>.L Ḷ
inoremap <C-k>.R Ṛ
inoremap <C-k>.M Ṃ
inoremap <C-k>.N Ṇ
inoremap <C-k>.S Ṣ
inoremap <C-k>.T Ṭ
inoremap <C-k>.D Ḍ
inoremap <C-k>.H Ḥ
"WINDOW
"" resize with ctrl-arrowkey
nnoremap <silent> <C-left> :vertical resize -3<CR>
nnoremap <silent> <C-right> :vertical resize +3<CR>
nnoremap <silent> <C-up> :resize -3<CR>
nnoremap <silent> <C-down> :resize +3<CR>
"FILE TREE
"" thanks:
""" https://shapeshed.com/vim-netrw/
""" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
"" set directory tree view
let g:netrw_liststyle= 3
"" hide banner
let g:netrw_banner= 0
"" open in prev window
let g:netrw_browse_split= 4
"" default size
let g:netrw_winsize=-25
"" open vert
let g:netrw_altv= 1
" fix opening faraway files
let g:netrw_keepdir = 0

" open on launch (don't `vim .`)
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Lexplore
augroup END

" bind open/close toggle
nnoremap <silent> <leader>a :Lexplore<cr>
"VIMSCRIPT!
 let g:firenvim_config = {
   \ 'globalSettings': {
     \ 'alt': 'all',
     \  },
   \ 'localSettings': {
     \ '.*': {
       \ 'cmdline': 'neovim',
       \ 'content': 'text',
       \ 'priority': 0,
       \ 'selector': 'textarea',
       \ 'takeover': 'never',
       \ },
     \ }
   \ }
