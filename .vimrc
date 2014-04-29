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
set viminfo+=n~/.vim/.viminfo

language C
syntax on

hi Comment cterm=none ctermfg=darkgreen
hi Statement cterm=none ctermfg=blue
hi Type cterm=none ctermfg=blue
hi Constant cterm=none ctermfg=grey
hi link Boolean Statement
hi String cterm=none ctermfg=red
hi link Character String
hi link SpecialChar String
hi PreProc ctermfg=grey
hi LineNr ctermfg=darkcyan

inoremap <Nul> <C-x><C-p>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

if has('vim_starting')
set runtimepath+=~/.vim/neobundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/neobundle/'))
filetype plugin indent on
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Rip-Rip/clang_complete'
"let g:clang_periodic_quickfix=1
"let g:clang_complete_copen=1
"let g:clang_use_library=0
"let g:clang_library_path='/usr/lib/llvm-3.0/lib'
"let g:clang_user_options='-std=c++1y -stdlib=libc++'
NeoBundle 'vim-jp/cpp-vim'

NeoBundleCheck
