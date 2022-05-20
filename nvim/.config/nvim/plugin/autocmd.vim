" Neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END
" Tabs for different languages
augroup langs
  autocmd!
  autocmd FileType python       setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END
" Markdown writing
augroup wiki
  autocmd!
  autocmd FileType vimwiki     setlocal wrap nornu nonumber breakindent formatoptions=1 lbr colorcolumn=0
  autocmd FileType vimwiki     nnoremap <silent> j gj
  autocmd FileType vimwiki     nnoremap <silent> k gk
  autocmd FileType vimwiki     GitGutterDisable
augroup END
