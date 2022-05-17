" CTRL+Backspace to delete a full word
inoremap <C-H> <C-W>
" Mac variant (alt + backspace)
inoremap <M-backspace> <C-W>

"nnoremap <leader>e <cmd>Ex<cr>
"nnoremap <leader>s <cmd>Sex<cr>
"nnoremap <leader>v <cmd>Vex<cr>

" C-^ is too hard
nnoremap <leader>b <C-^>

" Terminal
" Normal mode using CTRL+[
tnoremap <C-[> <C-\><C-n>

" Register stuff
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Yank to end of line
nnoremap Y y$

" Keep cursor on same line when searching/Jing
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo Break Points
" Character can be anything
inoremap , ,<C-g>u
inoremap . .<C-g>u

" Jumplist mutations (CTRL-O and CTRL-I)
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==a
inoremap <C-k> <esc>:m .-2<CR>==a
nnoremap <leader>J :m .+1<CR>==
nnoremap <leader>K :m .-2<CR>==

" Goyo
nnoremap <leader>z :Goyo<CR>
