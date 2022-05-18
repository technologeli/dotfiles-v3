" File finders
nnoremap <leader>rg <cmd>lua require('telescope.builtin').grep_string(require('telescope.themes').get_ivy({search=vim.fn.input("Grep For > ")}))<cr>
nnoremap <C-p>      <cmd>Telescope git_files theme=ivy<cr>
nnoremap <leader>f  <cmd>Telescope find_files theme=ivy hidden=true<cr>
nnoremap <C-f>      <cmd>Telescope find_files theme=ivy hidden=true search_dirs={"~/dotfiles-v3","~/school","~/work","~/personal"}<cr>
nnoremap <leader>.  <cmd>Telescope find_files theme=ivy hidden=true search_dirs={"~/dotfiles-v3"}<cr>
nnoremap <C-b>      <cmd>Telescope buffers theme=ivy<cr>

" LSP
nnoremap <leader>lr <cmd>Telescope lsp_references theme=ivy hidden=true<cr>
nnoremap <leader>ld <cmd>Telescope lsp_definitions theme=ivy hidden=true<cr>
nnoremap <leader>lt <cmd>Telescope lsp_type_definitions theme=ivy hidden=true<cr>

" Help docs
nnoremap <leader>hd <cmd>Telescope help_tags theme=ivy<cr>

lua << EOF
local actions = require'telescope.actions'
require'telescope'.setup {
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
    mappings = {
      i = {
      },
      n = {
        ["q"] = actions.close,
        ["l"] = actions.select_default + actions.center
      }
    }
  }
}
EOF
