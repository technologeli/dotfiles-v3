call plug#begin('~/.local/share/nvim/plugged')

" Gam
"Plug 'ThePrimeagen/vim-be-good'

" ()
" Plug 'rstacruz/vim-closer'

" Theming
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Ex-treem
Plug 'kyazdani42/nvim-tree.lua'

" TREE
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/playground'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
"Plug 'ray-x/lsp_signature.nvim'

"Plug 'nvim-lua/completion-nvim'
" Snip
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Format
Plug 'sbdchd/neoformat'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'stsewd/fzf-checkout.vim'

" Colors
"Plug 'ap/vim-css-color'
Plug 'norcalli/nvim-colorizer.lua'

" Harpoon
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'ThePrimeagen/harpoon'

" Binding bad
Plug 'folke/which-key.nvim'

call plug#end()

let mapleader = ' '
