set number
set ruler
set nowrap
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
set nocompatible
set tabstop=4
set showmatch
set smartindent
set wildmenu
set wildmode=longest:full,full
set shortmess+=I
set viminfo+=n~/.vim/.viminfo
set ignorecase
set smartcase

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

inoremap <nul> <c-x><c-p>
inoremap <c-k> <up>
inoremap <c-j> <down>
inoremap <c-l> <right>
inoremap <c-h> <left>
inoremap <c-up> <esc><c-y>a
inoremap <c-down> <esc><c-e>a
nnoremap <c-up> <c-y>
nnoremap <c-down> <c-e>
nnoremap <silent><f5> :QuickRun<cr>
nnoremap <s-f5> <c-w>o
nnoremap <silent><c-f> :ClangFormat<cr>
nmap <f2> <plug>(altr-forward)

augroup cpp-path
	autocmd!
	autocmd filetype cpp setlocal path=.,/usr/include/c++/v1
augroup END

if has('vim_starting')
	set runtimepath+=~/.vim/neobundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/neobundle/'))
filetype plugin indent on
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-altr'
NeoBundle 'rhysd/vim-clang-format'
let g:clang_format#style_options=
\{
\'BasedOnStyle' : 'google',
\'Standard' : 'C++11',
\'BreakBeforeBraces' : 'Allman'
\}
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config={}
let g:quickrun_config._={'runner' : 'vimproc'}
let g:quickrun_config=
\{
\	'cpp' :
\	{
\		'command' : "clang++",
\		'cmdopt' : '-Wall -std=c++1y -stdlib=libc++',
\	},
\}
NeoBundleCheck

