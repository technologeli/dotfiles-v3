local mark = require'harpoon.mark'
local ui = require'harpoon.ui'

vim.api.nvim_set_keymap('n', '<leader>ha', '', {
  noremap = true,
  callback = function()
    mark.add_file()
  end
})

vim.api.nvim_set_keymap('n', '<leader>hh', '', {
  noremap = true,
  callback = function()
    ui.toggle_quick_menu()
  end
})

for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>h'..i, '', {
    noremap = true,
    callback = function()
      ui.nav_file(i)
    end
  })
end
