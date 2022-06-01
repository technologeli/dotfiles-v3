" Autoinstall Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/plugged')

" Theming
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pantharshit00/vim-prisma'

" Ex-treem
Plug 'kyazdani42/nvim-tree.lua'

" TREE
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/playground'

" LSP
Plug 'neovim/nvim-lspconfig'

" CMP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'

" Snip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'


" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'stsewd/fzf-checkout.vim'

" Colors
Plug 'norcalli/nvim-colorizer.lua'

" Harpoon
Plug 'ThePrimeagen/harpoon'

" Binding bad
Plug 'folke/which-key.nvim'

" Vimwiki
Plug 'vimwiki/vimwiki'
Plug 'folke/zen-mode.nvim'

" Formatting
Plug 'sbdchd/neoformat'

call plug#end()

let g:neoformat_try_node_exe = 1

let mapleader = ' '
