package.path = "/nix/store/1xxk4407nkicxp7g43w9z67495sfb5f7-luajit-2.1.1774638290-env/share/lua/5.1/?.lua;/nix/store/1xxk4407nkicxp7g43w9z67495sfb5f7-luajit-2.1.1774638290-env/share/lua/5.1/?/init.lua".. ";" .. package.path
package.cpath = "/nix/store/1xxk4407nkicxp7g43w9z67495sfb5f7-luajit-2.1.1774638290-env/lib/lua/5.1/?.so".. ";" .. package.cpath

vim.g.loaded_node_provider=0;vim.g.loaded_perl_provider=0;vim.g.loaded_ruby_provider=0;vim.g.loaded_python3_provider=0
vim.cmd.source "/nix/store/l8d16qxsi5s8q55zwlva0yk0r0szrc0a-init.vim"

--LUA!
   --[[asm       ]] vim.lsp.enable('asm-lsp')
   --[[godot     ]] vim.lsp.enable('gdscript')
   --[[html/css  ]] vim.lsp.enable('emmet-ls')
   --[[nix       ]] vim.lsp.enable('nixd')
   --[[typescript]] vim.lsp.enable('ts_ls')
   --[[zig       ]] vim.lsp.enable('zls')

   vim.opt.signcolumn="number" -- put icons in number column
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
vim.lsp.config('asm-lsp', { capabilities = capabilities }) -- why?
require("obsidian").setup({
  workspaces = {
    {
      name = "ObMain",
      path = "~/Documents/obsidian-vaults/ObMain",
    },
    {
      name = "magic",
      path = "~/Documents/obsidian-vaults/magic",
    },
    {
      name = "Music",
      path = "~/Documents/obsidian-vaults/Music",
    },
  },
  
  legacy_commands = false, -- silence deprecation message
  ui = {enable = false,}, -- suppress error: conceallevel=0, no cool unicode md rendering
  -- create new notes named title.md
  note_id_func = function(title) return title end,
  note_path_func = function(spec)
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md")
  end,
})

-- user-associated plugin config {{{
require('mini.base16').setup({
  palette = {
    base00 = '#131513', base01 = '#242924', base02 = '#5e6e5e', base03 = '#687d68',
    base04 = '#809980', base05 = '#8ca68c', base06 = '#cfe8cf', base07 = '#f4fbf4',
    base08 = '#e6193c', base09 = '#87711d', base0A = '#98981b', base0B = '#29a329',
    base0C = '#1999b3', base0D = '#3d62f5', base0E = '#ad2bee', base0F = '#e619c3'
  }
})



-- }}}
