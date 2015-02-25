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
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%4c%V%4P[%l/%L]
set laststatus=2
set showcmd
set matchpairs+=<:>
set matchtime=0
set splitright

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
noremap <silent> <c-w>c :tabnew<cr>
noremap <silent> <c-w>" :split<cr>
noremap <silent> <c-w># :vsplit<cr>
noremap <c-w><space> <c-w>=
noremap <c-w>x <c-w>q
noremap <c-w>n gt
noremap <c-w>p gT
noremap <c-w><c-n> <nop>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
inoremap <silent> <f5> <esc>:QuickRun<cr>
noremap <silent> <f5> <esc>:QuickRun<cr>
nmap <f2> <plug>(altr-forward)
nnoremap <silent> <esc><esc> :noh<cr>
nnoremap <silent> <c-n> :cn<cr>
nnoremap <silent> <c-p> :cp<cr>
nnoremap <c-g><c-g> :Gtags<cr><cr>
nnoremap <c-g>g :Gtags -g<cr><cr>
nnoremap <c-g>r :Gtags -r<cr><cr>
nnoremap <c-g>f :Gtags -f<cr><cr>
nnoremap <c-f>f :Unite file<cr>

function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
		let no = i  " display 0-origin tabpagenr.
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
set showtabline=2

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
let g:unite_enable_start_insert=1
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

