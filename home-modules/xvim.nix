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
  vimLSP = ''
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
  nvimLSP = '' --LUA!
    --[[godot     ]] vim.lsp.enable('gdscript')
    --[[html/css  ]] vim.lsp.enable('emmet-ls')
    --[[nix       ]] vim.lsp.enable('nixd')
    --[[typescript]] vim.lsp.enable('ts_ls')
    --[[zig       ]] vim.lsp.enable('zls')

    vim.opt.signcolumn="number" -- put icons in number column
  '';
  nvimCmp = ''
    local cmp = require('cmp')
    local cmp_select = {behavior = cmp.SelectBehavior.Select}

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' }
      })
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
    
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    vim.lsp.config('*', {
      capabilities = capabilities,
    })
    vim.lsp.config('emmet-ls', { capabilities = capabilities }) -- why?
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
    + vimLSP
    + filetree
    ;
    plugins = with pkgs.vimPlugins; [ vim-lsp vim-lsp-settings ];
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    #vimAlias = true; # keep false
    vimdiffAlias = true;
    extraConfig =
      extraSettings
    + binds
    + sanskritBinds
    + windowBinds
    + filetree
    #+ "colorscheme elflord"
    ;
    extraLuaConfig =
      nvimLSP
    + nvimCmp
    ;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline

      firenvim

      nvim-treesitter
      nvim-treesitter-parsers.asm
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.cmake
      nvim-treesitter-parsers.commonlisp
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.css
      nvim-treesitter-parsers.csv
      nvim-treesitter-parsers.desktop
      nvim-treesitter-parsers.diff
      nvim-treesitter-parsers.gdscript
      nvim-treesitter-parsers.gdshader
      nvim-treesitter-parsers.git_config
      nvim-treesitter-parsers.git_rebase
      nvim-treesitter-parsers.gitcommit
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.glsl
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.hlsl
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.hyprlang
      nvim-treesitter-parsers.java
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.jq
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.kitty
      nvim-treesitter-parsers.kotlin
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.nasm
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.odin
      nvim-treesitter-parsers.passwd
      nvim-treesitter-parsers.powershell
      nvim-treesitter-parsers.printf
      nvim-treesitter-parsers.prolog
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.scheme
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.tmux
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.vim
      nvim-treesitter-parsers.wgsl
      nvim-treesitter-parsers.wgsl_bevy
      nvim-treesitter-parsers.xml
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.zig
    ];
  };
}
