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
