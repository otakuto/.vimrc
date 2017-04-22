set nocompatible
set number
set ruler
set nowrap
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set showmatch
set wildmenu
set wildmode=longest:full,full
set shortmess+=I
set viminfo+=n~/.vim/.viminfo
set ignorecase
set smartcase
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%4c%V%4P[%l/%L]
set laststatus=2
set showtabline=2
set showcmd
set matchpairs+=<:>
set matchtime=0
set splitright
set notimeout
set nottimeout
set autochdir
set encoding=utf-8
set fileencoding=utf-8

language C
syntax on
highlight Comment ctermfg=darkgreen cterm=none
highlight Constant ctermfg=grey cterm=none
highlight Type ctermfg=blue cterm=bold term=none
highlight Statement ctermfg=blue cterm=bold term=none
highlight link Boolean Type
highlight String ctermfg=red cterm=bold
highlight link Character String
highlight link SpecialChar String
highlight Search ctermfg=white ctermbg=darkmagenta cterm=bold
highlight link IncSearch Search
highlight MatchParen ctermbg=cyan
highlight PreProc ctermfg=grey
highlight LineNr ctermfg=darkcyan
highlight Pmenu ctermfg=black ctermbg=cyan
highlight StatusLine ctermfg=black ctermbg=white cterm=none term=none
highlight StatusLineNC ctermfg=white ctermbg=black cterm=none term=none

highlight TabLineFill ctermbg=white ctermfg=black cterm=bold term=none
highlight TabLine ctermbg=white ctermfg=black cterm=bold term=none
highlight TabLineSel ctermbg=black ctermfg=white cterm=bold term=none

highlight EasyMotionTarget ctermfg=white ctermbg=darkmagenta cterm=bold

inoremap {} {}<left>
inoremap [] []<left>
inoremap () ()<left>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap `` ``<left>
inoremap <> <><left>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-o> <backspace>
noremap <c-h> b
noremap <c-j> <c-e>j
noremap <c-k> <c-y>k
noremap <c-l> w
cnoremap <c-h> <left>
cnoremap <c-l> <right>
cnoremap <c-o> <backspace>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
noremap s <nop>
noremap sh <c-w>h
noremap sj <c-w>j
noremap sk <c-w>k
noremap sl <c-w>l
noremap sH <c-w>H
noremap sJ <c-w>J
noremap sK <c-w>K
noremap sL <c-w>L
noremap sx <c-w>q
noremap sq <c-w>q
noremap sn gt
noremap sp gT
noremap s<space> <c-w>=
noremap <silent> sc :tabnew<cr>
noremap <silent> sb :Unite buffer -tab<cr>
noremap <silent> sw :Unite window -tab<cr>
noremap <silent> s" :split<cr>
noremap <silent> s@ :split<cr>
noremap <silent> s# :vsplit<cr>
noremap x "_x
noremap X "_dd
vnoremap p "0p
vnoremap i I
vnoremap * "zy:let @/ = @z<cr>n
nnoremap A :a!<cr>
inoremap <silent> <f5> <esc>:QuickRun<cr>
nnoremap <silent> <f5> <esc>:QuickRun<cr>
inoremap <silent> <f6> <esc>:silent !cd build && make && ./a.out<cr>:redraw!<cr>
nnoremap <silent> <f6> <esc>:silent !cd build && make && ./a.out<cr>:redraw!<cr>
inoremap <silent> <f7> <esc>:Unite build<cr>
nnoremap <silent> <f7> <esc>:Unite build<cr>
nmap <f2> <plug>(altr-forward)
map ; <plug>(easymotion-s2)
map f <plug>(easymotion-bd-fl)
map t <plug>(easymotion-bd-tl)
map / <plug>(incsearch-forward)
map ? <plug>(incsearch-backward)
nnoremap <silent> <c-n> :cn<cr>
nnoremap <silent> <c-p> :cp<cr>
nnoremap <silent> <space><space> :noh<cr>
noremap <space>w :w<cr>
nnoremap <space> <nop>
nmap <space>g [Gtags]
nnoremap [Gtags] <nop>
nnoremap [Gtags]g :Gtags<cr><cr>
nnoremap [Gtags]e :Gtags -g<cr><cr>
nnoremap [Gtags]r :Gtags -r<cr><cr>
nnoremap [Gtags]f :Gtags -f<cr><cr>
nmap <space>u [Unite]
nnoremap [Unite] <nop>
nnoremap <silent> [Unite]f :Unite file -tab<cr>
nnoremap <silent> [Unite]F :Unite file -no-split<cr>

function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]
		let no = i
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr), ':t')
		let title = '[' . title . ']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill# '
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

for n in range(1, 9)
	execute 'nnoremap <silent> s'.n ':<c-u>tabnext'.n.'<cr>'
endfor

augroup cpp-path
	autocmd!
	autocmd filetype cpp setlocal path=.,/usr/include/boost/,/usr/include/c++/v1/
augroup END

augroup vimrc-auto-mkdir
	autocmd!
	autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
	function! s:auto_mkdir(dir, force)
	if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
	call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
	endif
	endfunction
augroup END

if !isdirectory(expand('~/.vim'))
	silent !mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
	silent !git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
filetype plugin indent on
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/unite-build')
call dein#add('vim-jp/cpp-vim')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-altr')
call dein#add('Lokaltog/vim-easymotion')
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
call dein#add('haya14busa/incsearch.vim')
call dein#add('rhysd/vim-clang-format')
let g:clang_format#style_options =
\{
\	'BasedOnStyle' : 'google',
\	'Standard' : 'C++11',
\	'BreakBeforeBraces' : 'Allman',
\}
call dein#add('thinca/vim-quickrun')
let g:quickrun_config =
\{
\	'_' :
\	{
\		'outputter' : 'multi:buffer:quickfix',
\		'runner' : 'vimproc',
\		'runner/vimproc/updatetime' : '10',
\		'hook/time/enable' : '1',
\	},
\	'cpp' :
\	{
\		'command' : 'clang++',
\		'cmdopt' : '-Wall -std=c++1z -stdlib=libc++',
\	},
\	'c' :
\	{
\		'command' : 'clang',
\		'cmdopt' : '-Wall -std=c11',
\	},
\}
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/unite.vim')
let g:unite_enable_split_vertically = 1
call dein#end()

if dein#check_install()
	call dein#install()
endif

function! s:remove_dust()
	let cursor = getpos(".")
	%s/\s\+$//ge
	call setpos(".", cursor)
	unlet cursor
endfunction
autocmd BufWritePre *[^(\.md)] call <SID>remove_dust()

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
autocmd BufNewFile *.hs 0r ! echo '
\import Control.Applicative\n
\import Data.Function\n
\\n
\main = do'
