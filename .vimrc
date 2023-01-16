syntax on
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set number relativenumber

filetype plugin indent on

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

