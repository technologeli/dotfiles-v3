nnoremap <leader>rg <cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input("Grep For > ")})<cr>
nnoremap <C-p>      <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>f  <cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>
nnoremap <C-f>      <cmd>lua require('telescope.builtin').find_files({hidden=true, search_dirs={"~/dotfiles-v3", "~/school", "~/work", "~/personal"}})<cr>
nnoremap <leader>.  <cmd>lua require('telescope.builtin').find_files({hidden=true, search_dirs={"~/dotfiles-v3"}})<cr>
nnoremap <C-b>      <cmd>lua require('telescope.builtin').buffers()<cr>

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
                ["q"] = actions.close,
                ["l"] = actions.select_default + actions.center
            }
        }
   }
}
EOF
