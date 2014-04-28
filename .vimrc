set number
set ruler
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
set nocompatible
set tabstop=4
set showmatch
set autoindent
set wildmenu
set wildmode=longest:full,full
set shortmess+=I
language C

syntax on

hi Comment cterm=none ctermfg=darkgreen
hi Statement cterm=none ctermfg=lightblue
hi Type ctermfg=lightblue
hi Constant cterm=none ctermfg=grey
hi link Boolean Statement
hi String cterm=none ctermfg=red
hi link Character String
hi link SpecialChar String
hi PreProc ctermfg=grey

imap <C-Space> <C-x><C-o>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'vim-jp/cpp-vim'

"let g:clang_periodic_quickfix=1
"let g:clang_complete_copen=1
"let g:clang_use_library=1
"let g:clang_library_path='/usr/lib/llvm-3.0/lib'
"let g:clang_user_options='-std=c++1y -stdlib=libc++'

"filetype plugin on
"NeoBundleCheck
