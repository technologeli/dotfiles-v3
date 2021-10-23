" Quickfix Lists
nnoremap <C-j>      <cmd>cnext<cr>zz
nnoremap <C-k>      <cmd>cprev<cr>zz
nnoremap <leader>k  <cmd>lnext<cr>zz
nnoremap <leader>j  <cmd>lprev<cr>zz
nnoremap <C-q>      <cmd>call ToggleQFList(1)<cr>
nnoremap <leader>q  <cmd>call ToggleQFList(0)<cr>

let g:qfl = 0
let g:qfg = 0

fun! ToggleQFList(global)
    if a:global
        if g:qfg == 1
            let g:qfg = 0
            cclose
        else
            let g:qfg = 1
            copen
        end
    else
        if g:qfl == 1
            let g:qfl = 0
            lclose
        else
            let g:qfl = 1
            lopen
        end
    endif
endfun
