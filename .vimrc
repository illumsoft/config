" This file is sources by gui and cli versions of vim

set nomodeline

" GUI version
if has('gui_running')
  set nocompatible
  silent! source $VIMRUNTIME/vimrc_example.vim
  silent! source $VIMRUNTIME/mswin.vim
  behave mswin

  au FileType crontab,fstab,make set noet ts=8 sw=8

  set guioptions-=T          " Remove toolbar
  set guioptions-=m          " Remove menu
  set guifont=Courier_New:h10:cRUSSIAN
  set encoding=utf-8
  "silent! colorscheme desert

  " Save session settings
  set sessionoptions+=resize,winpos
  if has('autocmd')
    let SESSION_LAST='~/.vim/session_last.vim'
    exec 'autocmd VIMEnter * :source '.SESSION_LAST
    exec 'autocmd VIMLeave * :mksession! '.SESSION_LAST
  endif

endif

" Highlight
syntax on
silent! colorscheme desert
"
set splitbelow
set encoding=utf-8
"
set noswapfile
set directory=~/tmp
" set swapsync=fsync
set swapsync=
set backupdir=~/tmp
set undodir=~/tmp
" set binary             " Edit file as-is - no conversion

" Search
" set notagbsearch       " avoid E432: Tags file not sorted: .../vim/vim81/doc/tags
set hlsearch           " highlight searching
set noignorecase       " Ignore case when searching
set showmatch          " Show matched (), {} etc
set noincsearch        " Disable search during typing in search field
set nowrapscan         " Do not wrap search
set foldmethod=syntax
let g:xml_syntax_folding=1
set autoindent
set shiftwidth=0       " autoindent shift. 0 - shift will be as tabstop
set cindent            " C code indent
set tabstop=4
set expandtab          " replace tabs with spaces
set scrolloff=1        " Lines at top and buttom when scroll
set history=512        " lines in command history

" set clipboard=unnamed  " set clipboard to unnamed to access the system clipboard under windows
set clipboard&         " do not map '*' register to anything

" Show filetype EOL type  and last modified timestamp, right after the filename
" set ruler
" nnoremap * :let @/ = '\<' . expand('<cword>') . '\>'<CR>
nnoremap * :let @/ = expand('<cword>')<CR>

" Show EOL type and last modified timestamp, right after the filename
" set statusline=%<%F%h%m%r\ [%{&ft}][%{&ff}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
" set statusline=%<%F%h%m%r[%{&fenc}]\ [%{&ft}][%{&ff}][%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
" set statusline=%<%F%h%m%r\ [%{&ft}][%{&ff}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
" set statusline=...%r%{VarExists('b:gzflag','\ [GZ]')}%h...

function IsSet(o,v1,v2)
  return a:o ? a:v1 : a:v2
endfunction

" Status line
set laststatus=2
set cmdheight=1

" set statusline=%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
" set statusline=%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=byte:%o,line:%l,col:%c%V\ %P
set statusline=b%{bufnr('%')}\ w%{winnr()}:%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=byte:%o,line:%l,col:%c%V\ %P

" highlight non ascii symbols
highlight nonascii guibg=DarkGreen ctermbg=DarkGreen term=standout
" au BufRead * syntax match nonascii "[^\u0000-\u007F]"
"highlight DiffAdd    term=bold ctermfg=7 ctermbg=4 guibg=Brown
"highlight DiffChange term=bold ctermfg=3 ctermbg=1 guibg=DarkMagenta
highlight DiffChange term=bold ctermbg=5 ctermfg=0 guibg=DarkGrey
highlight DiffText   term=reverse cterm=bold ctermbg=0 ctermfg=1 gui=bold guibg=Cyan
highlight Search     term=none ctermfg=4 ctermbg=7 guifg=wheat guibg=peru
" Green 2; Brown 3;
highlight sqlSpecial   term=bold ctermfg=3 guifg=navajowhite
highlight sqlKeyword   term=bold ctermfg=3 guifg=navajowhite
highlight sqlOperator  term=bold ctermfg=3 guifg=navajowhite
highlight sqlStatement term=bold ctermfg=3 guifg=navajowhite


" Space for fold (zc)/unfold (zo)
nnoremap <space> za

" Fix tabs after copy&paste
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" Select on * and on # (whole word only)
nnoremap * :let @/=expand('<cword>')<CR>
nnoremap # :let @/='\<'.expand('<cword>').'\>'<CR>

" Run selected block or current line
vnoremap ,R :.w !ksh<CR>
nnoremap ,r :exec '!'.getline('.')<CR>

" Calc line under cursor with bc
nnoremap ,b :exec 'r!' . 'echo "' . getline(".") . '" \| bc -l'<CR>kA = <ESC>J

" Enter current Date
"nnoremap ,d :r!date /T<CR>:r!time /T<CR>kJ:s/\s*\r//g<CR>:let @/ = ''<CR>
nnoremap ,d o<Esc>"=strftime("%Y-%m-%d %H:%M:%S")<CR>p

"From next line up to the end
"search for a word under cursor and add 'NULL' at the begining of found lines
"nnoremap ,n :let @n=expand('<cword>')<CR>:let @l=line(".")<CR>:exec ":.+,$s/^\\(.*" . @n . "\\)/NULL\\1/"<CR>:exec ":" . @l<CR>

""" Compile and run current file
" ISO/IEC 14882:1998 -ansi -std=c++98
" ISO/IEC 14882:2003 -std=c++03
" ISO/IEC 14882:2011 -std=c++11
" ISO/IEC 14882:2014 -std=c++14
" C90 9899:1990
" C11 9899:2011

" GCC C
nnoremap ,gcca :w \| :exec '!'.'gcc -x c -ansi -pedantic -Wall -Wno-format -O0 -o '.expand('%:r').' '.expand('%')

nnoremap ,gcc :w \| :exec '!'.'gcc -x c -std=iso9899:2011 -pedantic -Wall -Wno-format -O0 -o '.expand('%:r').' '.expand('%')
nnoremap ,gccm :w \| :exec '!'.'gcc -x c -std=iso9899:2011 -pedantic -Wall -Wno-format -O0 -lm -frounding-math -o '.expand('%:r').' '.expand('%')
nnoremap ,gcci :w \| :exec '!'.'gcc -x c -E -std=iso9899:2011 -pedantic -Wall -Wno-format -O0 -o '.expand('%:r').' '.expand('%')

" GNU C++
nnoremap ,g++a :w \| :exec '!'.'g++ -x c++ -ansi -pedantic -Wall -Wno-format -O0 -o ansi_'.expand('%:r').' '.expand('%')
nnoremap ,g++ :w \| :exec '!'.'g++ -m64 -x c++    -std=c++11 -fno-elide-constructors -pedantic -Wall -Wno-format -O0 -o gcc_'.expand('%:r').' '.expand('%')
nnoremap ,g++m :w \| :exec '!'.'g++ -m64 -x c++    -std=c++11 -fno-elide-constructors -pedantic -Wall -Wno-format -O0 -lm -frounding-math -o gcc_'.expand('%:r').' '.expand('%')
nnoremap ,g++i :w \| :exec '!'.'g++ -m64 -x c++ -E -std=c++11 -fno-elide-constructors -pedantic -Wall -Wno-format -O0 -o gcc_'.expand('%:r').'.i '.expand('%')

" Sun's C
nnoremap ,cc :w \| :exec '!'.'cc -xc99 -xO0 -o sun_'.expand('%:r').' '.expand('%')
" Sun's C++
nnoremap ,CC :w \| :exec '!'.'CC -m64 -xO0 -o sun_'.expand('%:r').' '.expand('%')

""" Count column total (numbers like 999 999,99, 9 999.99, 9999.9)
" 1. Copy column into register a - Ctrl-V <select block> ; "ay
" 2. Put the following line into register c
":let @a=substitute(@a,'\s\+','','g') | let @a=substitute(@a,',','.','g') | let @a=substitute(@a,'\n','+','g')a=a
" 3. Go to the position after which the result must be inserted
" 4. Execute register c - @c
