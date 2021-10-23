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

highlight TelescopeSelectionCaret guifg=#61afef
highlight TelescopeSelection      guifg=#abb2bf gui=bold
highlight TelescopeBorder         guifg=#c678dd
highlight TelescopeMatching       guifg=#e5c07b
highlight TelescopePromptPrefix   guifg=#61afef
