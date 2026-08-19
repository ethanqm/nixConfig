{ pkgs, ...}:{

  environment.systemPackages = (with pkgs; [
      # dev
      lua luajit
      python314
      nodejs deno typescript typescript-language-server
      zig zls
      racket # lisp
      gcc
      gdb lldb
      nixd # lsp
      emmet-ls # html/css lsp
      asm-lsp
  ]);
}
