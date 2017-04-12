" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdcommenter' 
Plug 'vim-syntastic/syntastic' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'airblade/vim-gitgutter' 
Plug 'pangloss/vim-javascript' 
Plug 'mxw/vim-jsx' 

call plug#end()

" Lucius theme options
colorscheme lucius
LuciusBlack
let g:lucius_contrast = 'low'
let g:lucius_contrast_bg = 'high'
let &t_Co=256
set background=dark

" vim-airline options
" Add vim-airline-powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme = 'lucius'

" Other Color Options
highlight LineNr ctermbg = Black

" GitGutter Options
highlight SignColumn ctermbg = Black
let g:gitgutter_sign_column_always = 1

" Undo Options
set undodir=~/.vim/undodir
set undolevels=1000 undoreload=10000
set undofile

" CtrlP Options
let g:ctrlp_map = '<leader>t'
let g:ctrlp_match_window = 'max:20'
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*.pyc

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Function to save cursor position when removing trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".") 
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip trailing whitespace from these filetypes upon write
autocmd FileType c,cpp,java,javascript,javascript.jsx,php,ruby,python,htmldjango,html,scss,css,markdown,rst,sql autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Open HTML files as HTML Django filetypes
au BufNewFile,BufRead *.html set filetype=htmldjango

" Open SSI files as HTML
au BufNewFile,BufRead *.ssi set filetype=html

" Call Flake8 on python save
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_ignore = "E501,W293,E265"

" Enable neocomplete on vim startup, remaps tab and space
set completeopt-=preview
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#min_syntax_length = 4
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
endfunction

" Use system clipboard
set clipboard=unnamed

" Make :W and :Q do the same thing as :w and :q
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" For php syntax checking
map <C-P> :!php -l %<CR>

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set incsearch
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


" Usability options
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['scss'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_debug = 0

" Let javascript files be linted with eslint
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'

" Syntastic python settings
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E501,E265,E131'
let g:syntastic_python_python_exec = '/usr/local/bin/python3'

" NerdCommenter
let NERDSpaceDelims = 1

" Turn vim into word processing mode
" func! WordProcessorMode()
  " setlocal formatoptions=1
  " setlocal noexpandtab
  " map j gj
  " map k gk
  " setlocal spell spelllang=en_us
  " set complete+=s
  " set formatprg=par
  " setlocal wrap
  " setlocal linebreak
" endfu
" com! WP call WordProcessorMode()

" Toggle relative line numbers on and off
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" Map Ctrl-n to toggling relative line numbers
nnoremap <C-n> :call NumberToggle()<cr>

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
