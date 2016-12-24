set nocompatible
filetype off
"Better command-line completion
set wildmenu
"Set the command window height to two lines
set cmdheight=2

"Set spellcheck and textwrap at 80 characters
set tw=80
setlocal spell

"Sets the runtime path to include and initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"List plugins here - new plugins will be installed after listing them here
"then running :PluginInstall in vim
Plugin 'gmarik/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'othree/html5.vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'jalvesaq/Nvim-R'
Plugin 'ervandew/screen'
Plugin 'jalvesaq/southernlights'

call vundle#end()
"End list of plugins

"Enable folding & set space to control folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Highlight last searched pattern
set hlsearch
"Show next search pattern while typing
set incsearch

"Enable syntax highlighting
syntax enable

filetype indent plugin on

syntax on
set number
set encoding=utf-8
set background=dark

au BufNewFile,BufRead *.js, *.html, *.shtml, *.css
	setlocal tabstop=2
	setlocal softtabstop=2
	setlocal shiftwidth=2

let python_hilight_all=1
