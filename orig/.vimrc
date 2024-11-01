colorscheme ron

filetype plugin indent on
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set cindent
set ruler

set backspace=indent,eol,start

cabbr <expr> %% expand('%:p:h')

:abbreviate grp exec git push-to-target

" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
