local setKey = vim.api.nvim_set_keymap

local l = function (k)
  return '<leader>' .. k
end

local c = function (com)
  return '<cmd>' .. com .. '<cr>'
end

local nore = { noremap = true }

-- Most commands look like this:
-- nnoremap <leader>{} <cmd>{}<cr>
-- So we can just make a table with those values
-- This also helps with duplicate catching
local tab = {
  -- Nvim Tree
  ['tt'] = 'NvimTreeFindFileToggle',
  ['tf'] = 'NvimTreeFocus',
  ['tr'] = 'NvimTreeRefresh',
  ['to'] = 'NvimTreeOpen',
  ['tc'] = 'NvimTreeClose',
  ['ts'] = 'NvimTreeResize 32',

  -- Telescope
  ['f'] = 'Telescope find_files hidden=true',
  ['.'] = 'Telescope find_files hidden=true search_dirs={"~/dotfiles-v3"}',
  ['lr'] = 'Telescope lsp_references hidden=true',
  ['hd'] = 'Telescope help_tags',

  -- Fugitive
  ['gs'] = 'Git',
  ['gc'] = 'GCheckout',
  ['gf'] = 'diffget //2',
  ['gj'] = 'diffget //3',

  -- Zen Mode
  ['z'] = 'ZenMode',
}

for k, v in pairs(tab) do
  setKey('n', l(k), c(v), nore)
end

-----------------
-- Other Stuff --
-----------------

-- Telescope special
setKey('n', '<C-p>', c('Telescope git_files'), nore)
setKey('n', '<C-b>', c('Telescope buffers'), nore)
setKey('n', l('rg'), '', {
  noremap = true,
  callback = function ()
    require('telescope.builtin').grep_string({
      search=vim.fn.input("Grep For > ")
    })
  end
})

-- Format
setKey('n', l('n'), '', {
  noremap = true,
  callback = vim.lsp.buf.formatting,
})

-- ctrl+backspace and mac variant
setKey('i', '<C-H>', '<C-W>', nore)
setKey('i', '<M-backspace>', '<C-W>', nore)

-- C-^ is too hard
setKey('n', l('b'), '<C-^>', nore)

-- Terminal
setKey('t', '<C-[>', '<C-\\><C-n>', nore)

-- Register Stuff
setKey('x', l('p'), '"_dP', nore)
setKey('n', l('y'), '"+y', nore)
setKey('v', l('y'), '"+y', nore)
setKey('n', l('d'), '"_d', nore)
setKey('v', l('d'), '"_d', nore)

-- Yank to EOL
setKey('n', 'Y', 'y$', nore)

-- Keep cursor on same line when searching/J-ing
setKey('n', 'n', 'nzzzv', nore)
setKey('n', 'N', 'Nzzzv', nore)
setKey('n', 'J', 'mzJ`z', nore)

-- Undo breakpoints
local chars = { ',', '.' }

for _, char in ipairs(chars) do
  setKey('i', char, char .. '<C-g>u', nore)
end

-- Jumplist mutations
local nore_expr = { noremap = true, expr = true }
setKey('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . \'k\'', nore_expr)
setKey('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . \'j\'', nore_expr)

-- Moving Text
local nore_silent = { noremap = true, silent = true }
setKey('v', 'J', ":m '>+1<cr>gv=gv", nore_silent)
setKey('v', 'K', ":m '>-2<cr>gv=gv", nore_silent)
-- setKey('i', '<C-j>', '<esc>:m .+1<cr>==a', nore_silent)
-- setKey('i', '<C-k>', '<esc>:m .-2<cr>==a', nore_silent)
-- setKey('n', l('J'), ':m .+1<cr>==', nore_silent)
-- setKey('n', l('K'), ':m .-2<cr>==', nore_silent)

-- Quickfix
setKey('n', '<C-j>', '<cmd>cnext<cr>zz', nore)
setKey('n', '<C-k>', '<cmd>cprev<cr>zz', nore)
setKey('n', '<C-q>', '', {
  noremap = true,
  callback = require('eli.qfl').toggle
})

-- Scratch
setKey('n', l('s'), '', {
  noremap = true,
  callback = require('eli.scratch').scratch
})
