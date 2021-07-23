" set the runtime path to include plugged and initialize
let rtp_prefix=exists('$SSHHOME')?expand($SSHHOME.'/.sshdot.d'):expand($HOME)
call plug#begin(rtp_prefix.'/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'google/vim-jsonnet'
Plug 'iloginow/vim-stylus'
Plug 'posva/vim-vue'
Plug 'jparise/vim-graphql'
Plug 'tomlion/vim-solidity'
if has('nvim')
    Plug 'neomake/neomake'
else
    Plug 'vim-scripts/Syntastic'
endif

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

" Use 256 colors!
set t_Co=256

" utf-8 encoding baby!
set encoding=utf-8

" Snappy
:set ttyfast

" Plugin Configuration

" Neovim Specific Configuration
if has('nvim')
    " Neomake Settings
    let g:neomake_python_enabled_makers = ['pep8']
    if findfile('build.gradle', '.;') !=# ''
      let g:neomake_java_enabled_makers = ['gradle']
    endif
    call neomake#configure#automake('w')
else
    " Syntastic Settings
    let g:syntastic_enable_signs=1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_echo_current_error=1
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_style_error_symbol = '✠'
    let g:syntastic_style_warning_symbol = '≈'
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
endif

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" Promptline Settings
let g:promptline_preset = {
    \'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
    \'b' : [ promptline#slices#user(), '\t' ],
    \'c' : [ promptline#slices#python_virtualenv(), '$(kube_ps1)' ],
    \'z' : [ promptline#slices#cwd({ 'dir_limit': 2 }), promptline#slices#vcs_branch() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}

" Ctrl-P Settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip   " MacOSX/Linux
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store'
    \ }
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" Make sure I can spell
" set spell spelllang=en_us

" Syntax Highlighting
syntax on
colorscheme molokai
let g:rehash256 = 1

" Use groovy highlighting for Jenkinsfiles
au BufNewFile,BufRead Jenkinsfile setf groovy


" Easy viewing of multiple files? Why not!
set hidden


" Line Numbers
set number


" What column am I in?
set ruler


" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full


" Enable mouse support in console (Has issues with git)
set mouse=a


" Highlight things found with search
set hlsearch
set incsearch


" Why make search case sensitive?
set ignorecase


" Highlight current line
set cursorline


" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Line length of 80
set colorcolumn=80


" Who doesn't like auto-indent?
set autoindent
set copyindent

" By default, use spaced tabs.
set expandtab
set smarttab

" Display tabs as 4 spaces wide. When expandtab is set, use 4 spaces.
set shiftwidth=4
set tabstop=4

function TabsOrSpaces()
    " Determines whether to use spaces or tabs on the current buffer.
    if getfsize(bufname("%")) > 256000
        " File is very large, just use the default.
        return
    endif

    let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

    if numTabs > numSpaces
        setlocal noexpandtab
    endif
endfunction

" Remove trailing whitespace from python files on write
autocmd BufWritePre *.py :%s/\s\+$//e

" Call the function after opening a buffer
autocmd BufReadPost * call TabsOrSpaces()


" This shows what you are typing as a command.
set showcmd


" Show that filename in that bottom
set ls=2


" Set that backspace to work
set backspace=indent,eol,start

" Map :w!! to allow writing file as sudo if opened normally
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work?answertab=active#tab-top
cmap w!! w !sudo tee > /dev/null %

" Set line count margin
set nuw=2

" Set nocp
set nocp

" Return cursor to previous location on file open
function! ResCur()
    if line("'\"") <= line("$")
    normal! g`"
    return 1
    endif
    endfunction

    augroup resCur
    autocmd!
autocmd BufWinEnter * call ResCur()
    augroup END

" Use ctrl+R in visual mode for quick replace of selection occurences
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
