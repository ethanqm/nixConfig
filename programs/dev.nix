{ pkgs, ...}:{

  environment.systemPackages = (with pkgs; [
      # dev
      lua
      python314
      nodejs_24 deno typescript typescript-language-server
      zig zls
      racket # lisp
      gcc
      gdb lldb
      nixd # lsp
      emmet-ls # html/css lsp
      asm-lsp
  ]);
}
