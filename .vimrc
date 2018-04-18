" This file is sources by gui and cli versions of vim

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
set hlsearch           " highlight searching
set noignorecase       " Ignore case when searching
set showmatch          " Show matched (), {} etc
set noincsearch        " Disable search during typing in search field
set nowrapscan         " Do not wrap search
set foldmethod=syntax  " indent
set shiftwidth=2       " autoindent shift
set laststatus=2       " always show status line
set cmdheight=1
set scrolloff=3        " Lines at top and buttom when scroll
set history=512        " lines in command history

" set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
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

" set statusline=%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
set statusline=%<%t%h%m%r[%{&ft}][%{&ff}][%{&fenc}]\ %{IsSet(&bin,'[bin]','[nobin]')}[%{&enc}]\ (%{strftime(\"%H:%M\ %Y/%m/%d\",getftime(expand(\"%:p\")))})%=byte:%o,line:%l,col:%c%V\ %P

let g:xml_syntax_folding=1
set noexpandtab          " no replace tabs with spaces

" highlight non ascii symbols
highlight nonascii guibg=DarkGreen ctermbg=DarkGreen term=standout
" au BufRead * syntax match nonascii "[^\u0000-\u007F]"
"highlight DiffAdd    term=bold ctermfg=7 ctermbg=4 guibg=Brown
"highlight DiffChange term=bold ctermfg=3 ctermbg=1 guibg=DarkMagenta
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

"if has("autocmd")
"  autocmd VIMEnter * :source ~/.vim/session_last.vim
"  autocmd VIMLeave * :mksession! ~/.vim/session_last.vim
"endif " has("autocmd")

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
  autocmd VIMEnter * :source ~/vimfiles/session_last.vim
  autocmd VIMLeave * :mksession! ~/vimfiles/session_last.vim
endif

" Select on *
nnoremap * :let @/=expand('<cword>')<CR>

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
