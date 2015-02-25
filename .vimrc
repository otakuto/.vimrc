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
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set laststatus=2
set showcmd

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
hi StatusLine ctermfg=white

inoremap <nul> <c-p>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-o> <backspace>
noremap <c-h> <left>
noremap <c-j> <down>
noremap <c-k> <up>
noremap <c-l> <right>
cnoremap <c-h> <left>
cnoremap <c-l> <right>
cnoremap <c-o> <backspace>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
nnoremap <silent> <f5> :QuickRun<cr>
nnoremap <silent> <c-f> :ClangFormat<cr>
nmap <f2> <plug>(altr-forward)
nnoremap <silent> <esc><esc> :noh<cr>
nnoremap <silent> <c-n> :cn<cr>
nnoremap <silent> <c-p> :cp<cr>
nnoremap <c-g><c-g> :Gtags<cr><cr>
nnoremap <c-g>g :Gtags -g<cr><cr>
nnoremap <c-g>r :Gtags -r<cr><cr>
nnoremap <c-g>f :Gtags -f<cr><cr>

augroup cpp-path
	autocmd!
	autocmd filetype cpp setlocal path=.,/usr/include/c++/v1/,
augroup END

if has('vim_starting')
	set runtimepath+=~/.vim/neobundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/neobundle/'))
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
\		'command' : 'clang++',
\		'cmdopt' : '-Wall -std=c++1z -stdlib=libc++',
\	},
\}
NeoBundle 'Shougo/unite.vim'
call neobundle#end()
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'bbchung/clighter'
"let g:clighter_libclang_file = '/usr/lib/libclang.so'
"hi link clighterStructDecl Type
"hi link clighterClassDecl Type
NeoBundleCheck

autocmd BufNewFile *.c 0r ! echo '
\\#include <stdio.h>\n
\\n
\int main()\n
\{\n
\}'
autocmd BufNewFile *.cpp 0r ! echo '
\\#include <iostream>\n
\\n
\int main()\n
\{\n
\}'

