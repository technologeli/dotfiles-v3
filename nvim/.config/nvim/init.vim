set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set exrc
set relativenumber
set number
set nohlsearch
set incsearch
set noswapfile
set nobackup
set undofile
set undodir=~/.local/share/nvim/undo
set noerrorbells
set nowrap
set hidden
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set mouse=a
set termguicolors
set cursorline
set formatoptions-=cro

call plug#begin('~/.local/share/nvim/plugged')

" Theming
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/lsp_signature.nvim'

"Plug 'nvim-lua/completion-nvim'

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
Plug 'ap/vim-css-color'

call plug#end()

" Theming
colorscheme onedark
highlight Normal guibg=none

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ ['lineinfo'],
  \              [ 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

" LSP
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua << EOF

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args) end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert,preview',
  },
  confirmation = {
    get_commit_characters = function(commit_characters)
      return vim.tbl_filter(function(char)
        return char ~= ',' and char ~= '(' and char ~= '.'
      end, commit_characters)
    end
  }
})

-- Setup lspconfig.
require('lspconfig')['tsserver'].setup {
  on_attach = function(client, bufnr) require'lsp_signature'.on_attach() end,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require('lspconfig')['pyright'].setup {
  on_attach = function(client, bufnr) require'lsp_signature'.on_attach() end,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require('lspconfig')['bashls'].setup {
  on_attach = function(client, bufnr) require'lsp_signature'.on_attach() end,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

EOF

" neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
" tabs for different languages
augroup langs
  autocmd!
  autocmd FileType javascript   setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript   setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json         setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html         setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType css          setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END


" netrw
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_bufsettings = 'noma nomod nu rnu nowrap ro nobl'

let mapleader = ' '
" CTRL+Backspace deletes a full word
inoremap <C-H> <C-W>

" Terminal
" Normal mode using CTRL+[
tnoremap <C-[> <C-\><C-n>

" Quickfix Lists
nnoremap <C-j>      <cmd>cnext<cr>zz
nnoremap <C-k>      <cmd>cprev<cr>zz
nnoremap <leader>k  <cmd>lnext<cr>zz
nnoremap <leader>j  <cmd>lprev<cr>zz
nnoremap <C-q>      <cmd>call ToggleQFList(1)<cr>
nnoremap <leader>q  <cmd>call ToggleQFList(0)<cr>

" Definitions
nnoremap <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>b <C-^>

" Default Mappings
" <C-x> open in a hsplit
" <C-v> open in a vsplit
" <C-t> open in a new tab

" Telescope
nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input("Grep For > ")})<cr>
nnoremap <C-p>      <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>f  <cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>
nnoremap <C-f>      <cmd>lua require('telescope.builtin').find_files({hidden=true, search_dirs={"~/dotfiles-v3", "~/school", "~/work", "~/personal"}})<cr>
nnoremap <leader>.  <cmd>lua require('telescope.builtin').find_files({hidden=true, search_dirs={"~/dotfiles-v3"}})<cr>
nnoremap <C-b>      <cmd>lua require('telescope.builtin').buffers()<cr>

" Fugitive
nnoremap <leader>gs <cmd>Git<cr>
nnoremap <leader>gc <cmd>GCheckout<cr>
" Merge helpers
nnoremap <leader>gf <cmd>diffget //2<cr>
nnoremap <leader>gj <cmd>diffget //3<cr>

" Yank to end of line
nnoremap Y y$

" Keep cursor on same line when searching/Jing
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo Break Points
" Character can be anything
inoremap , ,<C-g>u
inoremap . .<C-g>u

" Jumplist mutations (CTRL-O and CTRL-I)
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==a
inoremap <C-k> <esc>:m .-2<CR>==a
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

let g:qfl = 0
let g:qfg = 0

fun! ToggleQFList(global)
    if a:global
        if g:qfg == 1
            let g:qfg = 0
            cclose
        else
            let g:qfg = 1
            copen
        end
    else
        if g:qfl == 1
            let g:qfl = 0
            lclose
        else
            let g:qfl = 1
            lopen
        end
    endif
endfun

" Telescope
highlight TelescopeSelectionCaret guifg=#61afef
highlight TelescopeSelection      guifg=#abb2bf gui=bold
highlight TelescopeBorder         guifg=#c678dd
highlight TelescopeMatching       guifg=#e5c07b
highlight TelescopePromptPrefix   guifg=#61afef

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--hidden',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        -- layout_strategy = "horizontal"
        layout_config = {
            horizontal = {
                preview_width = 0.6
            }
        },
        mappings = {
            i = {
            },
            n = {
                ["l"] = actions.select_default + actions.center
            }
        }
   }
}
EOF

lua << EOF

--[[
-- lua comment lol
-- python
require'lspconfig'.pyright.setup{
    on_attach=require'completion'.on_attach
}
-- typscript
require'lspconfig'.tsserver.setup{
    on_attach=require'completion'.on_attach
}
-- lua
local system_name
local sumneko_root_path
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
    -- TODO
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
    sumneko_root_path = "/home/eli/.sources/lua-language-server"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
    -- TODO
else
    print("Unsupported system for sumneko")
end
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    on_attach=require'completion'.on_attach,
    -- im too lazy to reindent this
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
--]]
EOF

