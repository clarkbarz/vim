setlocal tabstop=4
setlocal shiftwidth=4

" For blade template indentation to work properly
autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade
