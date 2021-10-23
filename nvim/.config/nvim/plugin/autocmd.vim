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
augroup END
