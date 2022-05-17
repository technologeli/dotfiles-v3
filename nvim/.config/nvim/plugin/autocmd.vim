" Neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END
" Tabs for different languages
augroup langs
  autocmd!
  autocmd FileType javascript   setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript   setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json         setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html         setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType css          setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType python       setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END
" Markdown writing
augroup wiki
  autocmd!
  autocmd FileType markdown     setlocal wrap nornu nonumber breakindent formatoptions=1 lbr
  autocmd FileType markdown     nnoremap <silent> j gj
  autocmd FileType markdown     nnoremap <silent> k gk
  autocmd FileType markdown     setlocal colorcolumn=0
augroup END
