{ pkgs, ...}:{

  environment.systemPackages = (with pkgs; [
      # dev
      python314
      nodejs_24 bun typescript typescript-language-server
      zig zls
      gcc
      gdb lldb
      nixd # lsp
      emmet-ls # html/css lsp
      asm-lsp
  ]);
}
