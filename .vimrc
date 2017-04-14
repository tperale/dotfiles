"-----------------------------------------------"
" Author:       Tim Sæterøy                     "
" Homepage:     http://thevoid.no               "
" Source:       http://github.com/timss/vimconf "
"-----------------------------------------------"

" vimconf is not vi-compatible
set nocompatible

""" Automatically make needed files and folders on first run
""" If you don't run *nix you're on your own (as in remove this) {{{
    call system("mkdir -p $HOME/.vim/{swap,undo}")
    if !filereadable($HOME . "/.vimrc.plugins") | call system("touch $HOME/.vimrc.plugins") | endif
    if !filereadable($HOME . "/.vimrc.first") | call system("touch $HOME/.vimrc.first") | endif
    if !filereadable($HOME . "/.vimrc.last") | call system("touch $HOME/.vimrc.last") | endif
""" }}}
let has_plug=1
if !filereadable($HOME."/.vim/autoload/plug.vim")
    echo "Installing PLUG..."
    echo ""
    silent !mkdir -p $HOME/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let has_plug=0
endif


call plug#begin('~/.vim/plugged')

    " Edit files using sudo/su
    Plug 'chrisbra/SudoEdit.vim'

    Plug 'vim-scripts/a.vim'

    " <Tab> everything!
    " Plugin 'ervandew/supertab'
    "
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.py -clang-completer' }
    " Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
    "
    " Plug 'Shougo/neocomplete.vim'

    " Autocompletion
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
    " STYLE
    Plug 'nanotech/jellybeans.vim'
    Plug 'tomasr/molokai'
    " A pretty statusline, bufferline integration
    Plug 'itchyny/lightline.vim'
    Plug 'bling/vim-bufferline'
    " A fancy start screen, shows MRU etc.
    Plug 'mhinz/vim-startify'
    " Show line indention.
    Plug 'Yggdroot/indentLine'

    " GIT
    " Git wrapper inside Vim
    Plug 'tpope/vim-fugitive'
    " Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
    Plug 'mhinz/vim-signify'

    " MOTION
    " Easy... motions... yeah.
    Plug 'Lokaltog/vim-easymotion'
    " Glorious colorscheme
    Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
    " UndoTree
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    " Super easy commenting, toggle comments etc
    " Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-commentary'
    " Autoclose (, " etc
    Plug 'Townk/vim-autoclose'
    " Handle surround chars like ''
    Plug 'tpope/vim-surround'
    " Align your = etc.
    Plug 'vim-scripts/Align'
    " A vim plugin that simplifies the transition between multiline and single-line code
    Plug 'AndrewRadev/splitjoin.vim'
    " Plug 't9md/choosewin'  
    " Multiple cursor
    Plug 'terryma/vim-multiple-cursors'
    " A command-line fuzzy finder written in Go
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
    " bundle of fzf-based commands and mappings
    Plug 'junegunn/fzf.vim'
    " Code searcher.
    Plug 'mileszs/ack.vim'
    " This plugin automatically adjusts 'shiftwidth' and 
    " 'expandtab' heuristically based on the current file
    Plug 'tpope/vim-sleuth'

    " function Build_Color_Coded(info)
    "       " info is a dictionary with 3 fields
    "       " - name:   name of the plugin
    "       " - status: 'installed', 'updated', or 'unchanged'
    "       "  - force:  set on PlugInstall! or PlugUpdate!
    "     if a:info.status == 'installed' || a:info.force
    "         |mkdir build && cd build
    "         |cmake ..
    "         |make && make install
    "         |make clean && make clean_clang
    "     endif
    " endfunction

    " " Better colors.
    " Plug 'jeaye/color_coded', { 'do' : function('Build_Color_Coded') }
    
    " Relative num in insert mode
    Plug 'myusuf3/numbers.vim' " , { 'on' : 'NumbersToggle' }

    Plug 'mattn/gist-vim', { 'on' : 'Gist' }
    Plug 'mattn/webapi-vim'

    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    " Include completion.
    Plug 'Shougo/neoinclude.vim'
    " Python completion.
    Plug 'zchee/deoplete-jedi'

    " Linter
    Plug 'w0rp/ale'

    " Omnicomplete for C family languages.
    " Plug 'zchee/deoplete-clang'
    Plug 'Rip-Rip/clang_complete'
    " lisp dev
    Plug 'mikaelj/limp', { 'for' : ['lisp', 'cl', 'scheme'] }
    " REPL clojure
    Plug 'tpope/vim-fireplace'     , { 'for' : 'clojure' }
    Plug 'tpope/vim-classpath'     , { 'for' : 'clojure' }
    Plug 'tpope/vim-leiningen'     , { 'for' : 'clojure' }
    Plug 'tpope/vim-projectionist' , { 'for' : 'clojure' }
    Plug 'tpope/vim-dispatch'      , { 'for' : 'clojure' }
    Plug 'tpope/vim-salve'         , { 'for' : 'clojure' }

    Plug 'slim-template/vim-slim'   , { 'for': 'slim'       }
    Plug 'wting/rust.vim'           , { 'for': 'rust'       }

    " Javascript plugins
    Plug 'pangloss/vim-javascript'                  , { 'for': ['javascript', 'jsx'] }
    Plug 'jelera/vim-javascript-syntax'             , { 'for': ['javascript', 'jsx'] }
    Plug 'mxw/vim-jsx'                              , { 'for': ['javascript', 'jsx'] }
    Plug 'othree/javascript-libraries-syntax.vim'   , { 'for': ['javascript', 'jsx'] }
    Plug 'jiangmiao/simple-javascript-indenter'     , { 'for': ['javascript', 'jsx'] }
    Plug 'epilande/vim-es2015-snippets'             , { 'for': ['javascript', 'jsx'] }
    Plug 'epilande/vim-react-snippets'              , { 'for': ['javascript', 'jsx'] }
    Plug 'kchmck/vim-coffee-script'                 , { 'for': 'coffee' }

    " Latex
    " Plug 'xuhdev/vim-latex-live-preview', { 'on': 'LLPStartPreview' }
    " A modern vim plugin for editing LaTeX files
    " Plug 'lervag/vimtex'

    " Syntax highlighting
    Plug 'saltstack/salt-vim'
    Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
    Plug 'gko/vim-coloresque'
    Plug 'othree/html5.vim'      , { 'for': 'html' }
    Plug 'mitsuhiko/vim-jinja'   , { 'for': 'html' }

    " Arduino
    Plug 'vim-scripts/Arduino-syntax-file'
    " Plug 'coddingtonbear/neomake-platformio'

    " Functions, class data etc.
    " REQUIREMENTS: (exuberant)-ctags
    Plug 'majutsushi/tagbar'


    " Text processing
    Plug 'plasticboy/vim-markdown'  , { 'for': 'markdown'   }
    Plug 'itchyny/dictionary.vim'
    " Correction orthographique.
    " Plugin 'dpelle/vim-LanguageTool '

    " A plugin to write plain-text notes.
    Plug 'junegunn/vim-journal'

    " Snippets
    Plug 'SirVer/ultisnips' 

call plug#end()

 

""" Installing plugins the first time, quits when done {{{
    if has_plug== 0
        :silent! PlugInstall
        :qa
    endif
""" }}}

""" Local leading config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
""" }}}
""" User interface {{{
    """ Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set background=dark                         " we're using a dark bg
        colorscheme molokai                      " colorscheme from plugin
        """ force behavior and filetypes, and by extension highlighting {{{
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        """ }}}
        """ 256 colors for maximum jellybeans bling. See commit log for info {{{
            if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            endif
        """ }}}
        """ Custom highlighting, where NONE uses terminal background {{{
            function! CustomHighlighting()
                highlight Normal ctermbg=NONE
                highlight NonText ctermbg=NONE
                highlight LineNr ctermbg=NONE
                highlight SignColumn ctermbg=NONE
                highlight SignColumn guibg=#151515
                highlight CursorLine ctermbg=235
            endfunction

            call CustomHighlighting()
        """ }}}
    """ }}}
    """ Interface general {{{
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
                    \*.jpeg,*.png,*.gif,*.pdf,*.git,
                    \*.swp,*.swo                    " tab completion ignores
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash-like auto complete
        """ Depending on your setup you may want to enforce UTF-8.
        """ Should generally be set in your environment LOCALE/$LANG {{{
            " set encoding=utf-8                    " default $LANG/latin1
            " set fileencoding=utf-8                " default none
        """ }}}
        """ Gvim {{{
            set guifont=DejaVu\ Sans\ Mono\ 9
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        """ }}}
    """ }}}
""" }}}
""" General settings {{{
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <tab>
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    if !has('nvim')
        set ttymouse=xterm2                             " experimental
    endif
    """ Folding {{{
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
    """ }}}
    """ Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    """ }}}
    """ Return to last edit position when opening files {{{
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    """ }}}
""" }}}
""" Files {{{
    set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ }}}
    """ Swap files, unless vim is invoked using sudo. Inspired by tejr's vimrc
    """ https://github.com/tejr/dotfiles/blob/master/vim/vimrc {{{
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            """ Don't swap tmp, mount or network dirs {{{
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                                \ setlocal noswapfile
                augroup END
            """ }}}
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
    """ Only auto-comment newline for block comments {{{
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    """ }}}
    """ Take comment leaders into account when joining lines, :h fo-table
    """ http://ftp.vim.org/pub/vim/patches/7.3/7.3.541 {{{
        if has("patch-7.3.541")
            set formatoptions+=j
        endif
    """ }}}
""" }}}
""" Keybindings {{{
    """ General {{{
        " Remap <leader>
        let mapleader=","

        " Quickly edit/source .vimrc
        noremap <leader>ve :edit $HOME/.vimrc<CR>
        noremap <leader>vs :source $HOME/.vimrc<CR>

        " Yank(copy) to system clipboard
        noremap <leader>y "+y

        " Yank from cursor to end of line
        nnoremap Y y$

        " Remap :W to :w
        command! W w

        " Sudo write (,W) {{{
        noremap <leader>W :w !sudo tee %<CR>}

        " Toggle folding
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Change window
        nnoremap <C-J> <C-W><C-J>
        nnoremap <C-K> <C-W><C-K>
        nnoremap <C-L> <C-W><C-L>
        nnoremap <C-H> <C-W><C-H>


        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " We don't need any help!
        inoremap <F1> <nop>
        nnoremap <F1> <nop>
        vnoremap <F1> <nop>

        " Disable annoying ex mode (Q)
        map Q <nop>

        " Buffers, preferred over tabs now with bufferline.
        nnoremap gn :bnext<CR>
        nnoremap gN :bprevious<CR>
        nnoremap gd :bdelete<CR>
        nnoremap gf <C-^>
    """ }}}
    """ Functions and/or fancy keybinds {{{{
        """ Vim motion on next found object like ci", but for ([{< etc
        """ - http://stackoverflow.com/a/14651443/1076493
        """ Based on gist by @AndrewRadev
        """ - https://gist.github.com/AndrewRadev/1171559
        """ For a crazier version with directions, more objects etc. see
        """ - https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc {{{
            function! s:NextTextObject(motion)
                echo
                let c = nr2char(getchar())
                exe "normal! f".c."v".a:motion.c
            endfunction

            onoremap a :<C-u>call <SID>NextTextObject('a')<CR>
            xnoremap a :<C-u>call <SID>NextTextObject('a')<CR>
            onoremap i :<C-u>call <SID>NextTextObject('i')<CR>
            xnoremap i :<C-u>call <SID>NextTextObject('i')<CR>
        """ }}}
        """ Toggle syntax highlighting {{{
            function! ToggleSyntaxHighlighthing()
                if exists("g:syntax_on")
                    syntax off
                else
                    syntax on
                    call CustomHighlighting()
                endif
            endfunction

            nnoremap <leader>s :call ToggleSyntaxHighlighthing()<CR>
        """ }}}
        """ Highlight characters past 79, toggle with <leader>h
        """ You might want to override this function and its variables with
        """ your own in .vimrc.last which might set for example colorcolumn or
        """ even the textwidth. See https://github.com/timss/vimconf/pull/4 {{{
            let g:overlength_enabled = 0
            highlight OverLength ctermbg=238 guibg=#444444

            function! ToggleOverLength()
                if g:overlength_enabled == 0
                    match OverLength /\%79v.*/
                    let g:overlength_enabled = 1
                    echo 'OverLength highlighting turned on'
                else
                    match
                    let g:overlength_enabled = 0
                    echo 'OverLength highlighting turned off'
                endif
            endfunction

            nnoremap <leader>h :call ToggleOverLength()<CR>
        """ }}}
        """ Toggle relativenumber using <leader>r {{{
            function! NumberToggle()
                if(&relativenumber == 1)
                    set number
                else
                    set relativenumber
                endif
            endfunction

            nnoremap <leader>r :call NumberToggle()<CR>
        """ }}}
        """ Toggle text wrapping, wrap on whole words
        """ For more info see: http://stackoverflow.com/a/2470885/1076493 {{{
            function! WrapToggle()
                if &wrap
                    set list
                    set nowrap
                else
                    set nolist
                    set wrap
                endif
            endfunction

            nnoremap <leader>w :call WrapToggle()<CR>
        """ }}}
        """ Remove multiple empty lines {{{
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction

            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>
        """ }}}
        """ Split to relative header/source {{{
            function! SplitRelSrc()
                let s:fname = expand("%:t:r")

                if expand("%:e") == "h"
                    set nosplitright
                    exe "vsplit" fnameescape(s:fname . ".cpp")
                    set splitright
                elseif expand("%:e") == "cpp"
                    exe "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction

            nnoremap <leader>le :call SplitRelSrc()<CR>
        """ }}}
        """ Strip trailing whitespace, return to cursor at save {{{
            function! <SID>StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex
                            \ autocmd BufWritePre <buffer> :call
                            \ <SID>StripTrailingWhitespace()
            augroup END
        """ }}}
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        map <F1> :TagbarToggle<CR>

        " Toggle pastemode, doesn't indent
        set pastetoggle=<leader>p
    """ }}}
""" }}}
""" Plugin settings {{{
    " Startify, the fancy start page
    let g:startify_bookmarks = [
        \ $HOME . "/.vimrc", $HOME . "/.vimrc.first",
        \ $HOME . "/.vimrc.last", $HOME . "/.vimrc.plugins"
        \ ]
    let g:startify_custom_header = [
        \ '   Author:      Perale Thomas',
        \ '   Matricule    000408160',
        \ '   Homepage:    http://github.com/thomacer',
        \ '   Source:      http://github.com/thomacer',
        \ ''
        \ ]

    " TagBar
    let g:tagbar_left = 0
    let g:tagbar_width = 30
    set tags=tags;/

    " Netrw - the bundled (network) file and directory browser
    let g:netrw_banner = 0
    let g:netrw_list_hide = '^\.$'
    let g:netrw_liststyle = 3

    " Automatically remove preview window after autocomplete (mainly for clang_complete)
    augroup RemovePreview
        autocmd!
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    augroup END

    """ Lightline {{{
        let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ 'active': {
            \     'left': [
            \         ['mode', 'paste'],
            \         ['readonly', 'fugitive'],
            \         ['ctrlpmark', 'bufferline']
            \     ],
            \     'right': [
            \         ['lineinfo'],
            \         ['percent'],
            \         ['fileformat', 'fileencoding', 'filetype']
            \     ]
            \ },
            \ 'component': {
            \     'paste': '%{&paste?"!":""}'
            \ },
            \ 'component_function': {
            \     'mode'         : 'MyMode',
            \     'fugitive'     : 'MyFugitive',
            \     'readonly'     : 'MyReadonly',
            \     'ctrlpmark'    : 'CtrlPMark',
            \     'bufferline'   : 'MyBufferline',
            \     'fileformat'   : 'MyFileformat',
            \     'fileencoding' : 'MyFileencoding',
            \     'filetype'     : 'MyFiletype'
            \ },
            \ 'subseparator': {
            \     'left': '|', 'right': '|'
            \ }
            \ }

        let g:lightline.mode_map = {
            \ 'n'      : ' N ',
            \ 'i'      : ' I ',
            \ 'R'      : ' R ',
            \ 'v'      : ' V ',
            \ 'V'      : 'V-L',
            \ 'c'      : ' C ',
            \ "\<C-v>" : 'V-B',
            \ 's'      : ' S ',
            \ 'S'      : 'S-L',
            \ "\<C-s>" : 'S-B',
            \ '?'      : '      ' }

        function! MyMode()
            let fname = expand('%:t')
            return fname == '__Tagbar__' ? 'Tagbar' :
                    \ fname == 'ControlP' ? 'CtrlP' :
                    \ winwidth('.') > 60 ? lightline#mode() : ''
        endfunction

        function! MyFugitive()
            try
                if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
                    let mark = '± '
                    let _ = fugitive#head()
                    return strlen(_) ? mark._ : ''
                endif
            catch
            endtry
            return ''
        endfunction

        function! MyReadonly()
            return &ft !~? 'help' && &readonly ? '≠' : '' " or ⭤
        endfunction

        function! MyBufferline()
            call bufferline#refresh_status()
            let b = g:bufferline_status_info.before
            let c = g:bufferline_status_info.current
            let a = g:bufferline_status_info.after
            let alen = strlen(a)
            let blen = strlen(b)
            let clen = strlen(c)
            let w = winwidth(0) * 4 / 11
            if w < alen+blen+clen
                let whalf = (w - strlen(c)) / 2
                let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
                let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
                return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
            else
                return b . c . a
            endif
        endfunction

        function! MyFileformat()
            return winwidth('.') > 90 ? &fileformat : ''
        endfunction

        function! MyFileencoding()
            return winwidth('.') > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! MyFiletype()
            return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        endfunction

        function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
            let g:lightline.ctrlp_regex = a:regex
            let g:lightline.ctrlp_prev = a:prev
            let g:lightline.ctrlp_item = a:item
            let g:lightline.ctrlp_next = a:next
            return lightline#statusline(0)
        endfunction

        function! CtrlPStatusFunc_2(str)
            return lightline#statusline(0)
        endfunction

        let g:tagbar_status_func = 'TagbarStatusFunc'

        function! TagbarStatusFunc(current, sort, fname, ...) abort
            let g:lightline.fname = a:fname
            return lightline#statusline(0)
        endfunction
    """ }}}
""" }}}
""" Local ending config, will overwrite anything above. Generally use this. {{{{
    if filereadable($HOME."/.vimrc.last")
        source $HOME/.vimrc.last
    endif
""" }}}

" Gist, Copy current file on gist.
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_post_private = 1
let g:gist_post_anonymous = 1

" ChooseWindow, choose in witch window, move.
" nmap - <Plug>(choosewin)

" Map start key separately from next key
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Latex preview
autocmd FileType tex setl updatetime=1
let g:livepreview_previewer = 'zathura'
nmap <F12> : LLPStartPreview<cr>

" Numbers.vim
nnoremap <F2> :NumbersOnOff<CR>
nnoremap <F3> :NumbersToggle<CR>

nnoremap <F4> :UndotreeToggle<cr>

" Deoplete autocompletion.
let g:deoplete#enable_at_startup = 1

function g:Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
endfunction

" ag code searcher
let g:ackprg = 'ag --vimgrep'

" Allow JSX in normal JS files
let g:jsx_ext_required = 0 

let g:ale_linters = {
\   'javascript': ['eslint'],
\}
