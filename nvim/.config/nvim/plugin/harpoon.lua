local has_harpoon, _ = pcall(require, 'harpoon')
if not has_harpoon then
  return
end

local mark = require'harpoon.mark'
local ui = require'harpoon.ui'

vim.api.nvim_set_keymap('n', '<leader>ha', '', {
  noremap = true,
  callback = mark.add_file
})

vim.api.nvim_set_keymap('n', '<leader>hh', '', {
  noremap = true,
  callback = ui.toggle_quick_menu
})

for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>h'..i, '', {
    noremap = true,
    callback = function()
      ui.nav_file(i)
    end
  })
end
