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

" Gam
"Plug 'ThePrimeagen/vim-be-good'

" ()
" Plug 'rstacruz/vim-closer'

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
Plug 'ThePrimeagen/harpoon'

" Binding bad
Plug 'folke/which-key.nvim'

" Vimwiki
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'

call plug#end()

let mapleader = ' '

let g:vimwiki_list = [{'path': '~/wikeli/', 'syntax': 'markdown', 'ext': '.md'}]
