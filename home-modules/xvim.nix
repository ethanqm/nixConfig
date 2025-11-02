{ config, pkgs, ... }:
let
  extraSettings = ''
    " case sensitive searches if capital present
    set ignorecase
    " mouse on
    set mouse=a
    " current line number
    set number
    " line distance
    set relativenumber

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
  '';
  binds = ''
    "BINDS
    nnoremap <space> <Nop>
    let mapleader=" "
    " toggle invisible characters
    nnoremap <silent> <leader>s :setlocal list!<cr>
  '';
  sanskritBinds = '' 
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
  '';
  windowBinds = ''
    "WINDOW
    "" resize with ctrl-arrowkey
    nnoremap <silent> <C-left> :vertical resize -3<CR>
    nnoremap <silent> <C-right> :vertical resize +3<CR>
    nnoremap <silent> <C-up> :resize -3<CR>
    nnoremap <silent> <C-down> :resize +3<CR>
  '';
  lsp = ''
    "LSP
    let g:lsp_diagnostics_enabled = 0
    let g:lsp_use_native_client = 1

    function! s:on_lsp_buffer_enabled() abort
      setlocal omnifunc=lsp#complete
      nmap <buffer> gd <plug>(lsp-definition)
      nmap <buffer> gr <plug>(lsp-references)
      nmap <buffer> K <plug>(lsp-hover)
    endfunction

    augroup lsp_install
      au!
      " call s:on_lsp_buffer_enabled only for languages that has the server registered.
      autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END
  '';
  filetree = ''
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
  '';
in
{
  programs.vim = {
    enable = true;
    extraConfig = 
      extraSettings 
      + binds
      + sanskritBinds
      + windowBinds
      + lsp
      + filetree
    ;
    plugins = with pkgs.vimPlugins; [ vim-lsp vim-lsp-settings ];
  };
}
