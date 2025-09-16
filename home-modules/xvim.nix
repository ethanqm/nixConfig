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
     set splitbelow splitright
   '';
in
{
  programs.vim = {
    enable = true;
    settings = commonSettings;
    extraConfig = extraSettings + sanskritBinds;
  };
}
