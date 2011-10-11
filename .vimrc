" vim/gvim configuration
"
" Jamie Iles

set nocp
filetype plugin on
set noexpandtab
set autoindent
set cindent
set cino=:0t0(0
set shiftwidth=8
set tabstop=8
set softtabstop=8
set smarttab
set bs=2

au BufWinEnter * call foreground()

syntax enable

set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
set textwidth=78

set formatoptions+=rotcqln

set switchbuf=useopen

" Show the matching parentheses when closing.
set showmatch

" Make sure that the status ruler is always showing.
set ruler

set background=dark

" Use incremental, highlighted search that is case insensitive unless the
" search term contains upper case letters.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spelling
let iSpellLang = 'british'
let personalDict = '~/.ispell_' . iSpellLang

" Allow autocompletion through spell dictionary.
execute 'set dictionary+=' . personalDict
set complete=.,w,k
set infercase

" tags and completion
set tags+=~/.vim/systags
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Backup options
set backup
set backupdir=~/Private/.vimbackup

" Allow Flint to work with QuickFix
set efm+=%f\ \ %l%m

set exrc

" Make sure that git commit logs start on the first line of the window.
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" When wrapping lines, break at the end of a word. Useful for antisocial text
" files that have gigantic lines
set linebreak

" Filename completion. Use completion like bash - try to complete as much as
" possible then present a list.
set wildmode=list:longest
set wildmenu
