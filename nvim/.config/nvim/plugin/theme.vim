if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme gruvbox

highlight Normal guibg=none
highlight Pmenu guibg=none
"highlight PmenuThumb guibg=#61afef
"highlight QuickFixLine guifg=#c678dd guibg=none
highlight PmenuThumb guibg=#458588
highlight QuickFixLine guifg=#b16286 guibg=none

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

"highlight TelescopeSelectionCaret guifg=#61afef
"highlight TelescopeSelection      guifg=#abb2bf gui=bold
"highlight TelescopeBorder         guifg=#c678dd
"highlight TelescopeMatching       guifg=#e5c07b
"highlight TelescopePromptPrefix   guifg=#61afef

"highlight VimwikiHeader1 guifg=#c678dd gui=bold
"highlight VimwikiHeader2 guifg=#61afef gui=bold
"highlight VimwikiHeader3 guifg=#e0af68 gui=bold
"highlight VimwikiHeader4 guifg=#56b6c2 gui=bold
"highlight VimwikiHeader5 guifg=#98c379 gui=bold
"highlight VimwikiHeader6 guifg=#e86671 gui=bold

highlight TelescopeSelectionCaret guifg=#458588
highlight TelescopeSelection      guifg=#a89984 gui=bold
highlight TelescopeBorder         guifg=#b16286
highlight TelescopeMatching       guifg=#d79921
highlight TelescopePromptPrefix   guifg=#458588

highlight VimwikiHeader1 guifg=#b16286 gui=bold
highlight VimwikiHeader2 guifg=#458588 gui=bold
highlight VimwikiHeader3 guifg=#d79921 gui=bold
highlight VimwikiHeader4 guifg=#689d6a gui=bold
highlight VimwikiHeader5 guifg=#98971a gui=bold
highlight VimwikiHeader6 guifg=#cc241d gui=bold
