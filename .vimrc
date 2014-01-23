set number
set clipboard=unnamed
set tabstop=4

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Rip-Rip/clang_complete'

let g:clang_periodic_quickfix = 1
let g:clang_complete_copen = 1
let g:clang_use_library = 1

" this need to be updated on llvm update
let g:clang_library_path = '/usr/lib/llvm-3.0/lib'
" specify compiler options
let g:clang_user_options = '-std=c++1y -stdlib=libc++'

filetype plugin on

NeoBundleCheck
