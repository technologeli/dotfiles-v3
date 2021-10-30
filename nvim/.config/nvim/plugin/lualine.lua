local mark = require'harpoon.mark'

local function harpoon()
  local m = mark.status()
  if m == "" then
    return m
  else
    return "H:" .. m
  end
end

require'lualine'.setup{
  -- disable separators
  options = {
    section_separators = '',
    component_separators = '|'
  },
  sections = {
    lualine_b = {
      {'FugitiveHead', icon = ''},
      {
        'diff',
        diff_color = {
          added = { fg = '#98c379' },
          removed = { fg = '#e86671' },
        },
      },
      {'diagnostics', sources={'nvim_lsp', 'coc'}}
    },
    lualine_c = {
      'filename',
      { harpoon }
    }
  }
}
