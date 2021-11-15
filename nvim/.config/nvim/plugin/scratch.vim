function Scratch() abort
  let bnr = bufnr("scratch")
  if bnr > 0
    buffer scratch
  else
    enew
    setlocal buftype=nofile
    file scratch
  endif
endfunction

nnoremap <leader>s <cmd>call Scratch()<cr>
