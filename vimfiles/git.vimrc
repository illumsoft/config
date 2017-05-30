
syntax on
colorscheme desert
" Set options
set hlsearch           " Highlight searching
set ignorecase         " Ignore case when searching
set showmatch          " Show matched (), {} etc
set noincsearch        " Disable search during typing in search field
set nowrapscan         " Do not wrap search
set foldmethod=syntax  " indent
" set encoding=utf-8
set encoding=cp1251    " need this for MADI repo
" set cmdheight=2
set expandtab          " replace tabs with spaces
set shiftwidth=2       " autoindent shift
set laststatus=2       " always show status line
set statusline=%<%F%h%m%r\ [%{&ft}][%{&ff}][%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
