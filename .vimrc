set nocompatible
set number
set ruler
set nowrap
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
set tabstop=4
set showmatch
set smartindent
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
hi MatchParen ctermbg=blue
hi StatusLine ctermfg=white ctermbg=black
hi StatusLineNC ctermfg=darkgrey ctermbg=white

hi TabLineFill ctermbg=white ctermfg=black cterm=none
hi TabLine ctermbg=white ctermfg=black cterm=none term=none
hi TabLineSel ctermbg=black ctermfg=white

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
inoremap { {}<left>
inoremap [ []<left>
inoremap ( ()<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap < <><left>
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
inoremap <silent> <f5> <esc>:QuickRun<cr>
noremap <silent> <f5> <esc>:QuickRun<cr>
nmap <f2> <plug>(altr-forward)
nnoremap <silent> <c-n> :cn<cr>
nnoremap <silent> <c-p> :cp<cr>
nnoremap <silent> <space><space> :noh<cr>
nmap <space>g [Gtags]
nnoremap [Gtags] <nop>
nnoremap [Gtags]g :Gtags<cr><cr>
nnoremap [Gtags]gr :Gtags -g<cr><cr>
nnoremap [Gtags]r :Gtags -r<cr><cr>
nnoremap [Gtags]f :Gtags -f<cr><cr>
nmap <space>u [unite]
nnoremap [unite] <nop>
nnoremap <silent> [unite]f :Unite file -tab<cr>

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
let g:clang_format#style_options =
\{
\	'BasedOnStyle' : 'google',
\	'Standard' : 'C++11',
\	'BreakBeforeBraces' : 'Allman',
\}
NeoBundle 'thinca/vim-quickrun'
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
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_split_vertically = 1
call neobundle#end()
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

