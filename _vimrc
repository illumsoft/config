" This file is sources by gui and cli versions of vim

" Set options
set noswapfile
set swapsync=
set directory=~/tmp
set backupdir=~/tmp
set undodir=~/tmp
" set binary             " Edit file as-is - no convertion
set hlsearch           " highlight searching
set noignorecase       " Ignore case when searching
set showmatch          " Show matched (), {} etc
set noincsearch        " Disable search during typing in search field
set nowrapscan         " Do not wrap search
set foldmethod=syntax  " indent
set shiftwidth=2       " autoindent shift
set laststatus=2       " always show status line
set cmdheight=1
set scrolloff=5

" set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set clipboard&         " do not map '*' register to anything

" nnoremap * :let @/ = '\<' . expand('<cword>') . '\>'<CR>
nnoremap * :let @/ = expand('<cword>')<CR>

" Show EOL type and last modified timestamp, right after the filename
" set statusline=%<%F%h%m%r\ [%{&ft}][%{&ff}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

function IsSet(o,v1,v2)
  return a:o ? a:v1 : a:v2
endfunction

set statusline=%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
" set swapsync=fsync
let g:xml_syntax_folding=1
set expandtab          " replace tabs with spaces

" highlight non ascii symbols
highlight nonascii guibg=DarkGreen ctermbg=DarkGreen term=standout
" au BufRead * syntax match nonascii "[^\u0000-\u007F]"

" Space for fold (zc)/unfold (zo)
nnoremap <space> za

" Fix tabs after copy&paste
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" GUI version
if has('gui_running')
  source ~/vimfiles/vimrc.gui
endif

