colorscheme onedark
highlight Normal guibg=none
highlight Pmenu guibg=none
highlight QuickFixLine guifg=#c678dd guibg=none

fun! Harpoon()
  let m = luaeval('require("harpoon.mark").status()')
  if m == ""
    return m
  else
    return "H:" . m
  endif
endfun

augroup HarpoonGroup
  autocmd!
  autocmd BufNewFile,BufReadPost * call Harpoon()
  autocmd BufEnter * call Harpoon()
augroup END

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ ['lineinfo'],
  \              [ 'fileencoding', 'filetype', 'harpoon' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'harpoon': 'Harpoon'
  \ },
  \ }

highlight TelescopeSelectionCaret guifg=#61afef
highlight TelescopeSelection      guifg=#abb2bf gui=bold
highlight TelescopeBorder         guifg=#c678dd
highlight TelescopeMatching       guifg=#e5c07b
highlight TelescopePromptPrefix   guifg=#61afef
