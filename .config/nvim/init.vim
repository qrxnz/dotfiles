call plug#begin()

" statusline
Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

" colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" autoapirs
Plug 'jiangmiao/auto-pairs'

" lsp
Plug 'neovim/nvim-lspconfig'
  Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'

call plug#end()

" lua configs
runtime lua/config.lua
