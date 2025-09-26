{ config, pkgs, ... }:
let
  commonSettings = {
    tabstop = 2;
    shiftwidth = 2;
    number = true;
    relativenumber = true;
    ignorecase = true;
    mouse = "a";
  };
  sanskritBinds = '' 
     " sanskrit binds
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
  extraSettings = ''
     set syntax=true
     set clipboard+=unnamedplus
     set nowrap
     set noswapfile
     set splitbelow splitright

     "set directory tree view
     let g:netrw_liststyle= 3
  '';
  lsp = ''
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
in
  {
    programs.vim = {
      enable = true;
      settings = commonSettings;
      extraConfig = 
          extraSettings 
          + sanskritBinds
          + lsp;
      plugins = with pkgs.vimPlugins; [ vim-lsp vim-lsp-settings ];
    };
  }
