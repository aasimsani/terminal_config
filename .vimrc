call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/xolox/vim-misc.git'
"Plug 'https://github.com/xolox/vim-colorscheme-switcher.git'
"Plug 'https://github.com/Yggdroot/indentLine.git'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'Taverius/vim-colorscheme-manager'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'Yggdroot/indentLine'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry
nnoremap gh <C-W><C-H> 
nnoremap gj <C-W><C-J> 
nnoremap gk <C-W><C-K> 
nnoremap gl <C-W><C-L> 

set number
map <Space> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
nmap <silent> <leader><bar> :call ToggleIndentGuidesTabs()<cr>
nmap <silent> <leader><bslash> :call ToggleIndentGuidesSpaces()<cr>

function! ToggleIndentGuidesTabs()
    if exists('b:iguides_tabs')
        setlocal nolist
        let &l:listchars = b:iguides_tabs
        unlet b:iguides_tabs
    else
        let b:iguides_tabs = &l:listchars
        setlocal listchars=tab:┆\ "protect the space
        setlocal list
    endif
endfunction

let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

function! ToggleIndentGuidesSpaces()
    if exists('b:iguides_spaces')
        call matchdelete(b:iguides_spaces)
        unlet b:iguides_spaces
    else
        let pos = range(1, &l:textwidth, &l:shiftwidth)
        call map(pos, '"\\%" . v:val . "v"')
        let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
        let b:iguides_spaces = matchadd("CursorLine",pat)
    endif
endfunction
call ToggleIndentGuidesSpaces()

