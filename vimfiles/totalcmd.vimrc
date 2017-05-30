
syntax on
colorscheme desert     " My favourite (most liked) scheme
winpos 400 5
" Set options
set binary             " Edit file as-is - no convertion
set hlsearch           " highlight searching
set noignorecase       " Ignore case when searching
set showmatch          " Show matched (), {} etc
set noincsearch        " Disable search during typing in search field
set nowrapscan         " Do not wrap search
set foldmethod=syntax  " indent
set laststatus=2       " always show status line
set guioptions-=T      " Remove toolbar
set guioptions-=m      " Remove menu
set encoding=utf-8
set guifont=Courier_New:h10:cRUSSIAN
set lines=60 columns=110
set cmdheight=1
set expandtab          " replace tabs with spaces
" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
set swapfile
set directory=~/tmp/
" set swapsync=fsync
set swapsync=


" highlight non ascii symbols
highlight nonascii guibg=DarkGreen ctermbg=DarkGreen term=standout
" au BufRead * syntax match nonascii "[^\u0000-\u007F]"
