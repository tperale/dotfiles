syntax on 

set background=dark
colorscheme SolarizedDark_modified

" Les fonctions sont cacher
set foldmethod=indent
set foldlevel=99

" affiche les chiffres dans la colonne a droite
set number

" Pathogen load
filetype on
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on


set shellslash

" EasySplit navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l



" I can type :help on my own, thanks.
noremap <F1> <Esc>
imap <F1> <Esc>



" Activer NERDTree avec \-n
map <leader>n :NERDTreeToggle<CR>

"on utilise \-n pour sauter jusqu a la def et \-r pour renommer

" map <leader>g :RopeGotoDefinition<CR>
" map <leader>r :RopeRename<CR>

" Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

" automatically reload vimrc when it's saved
    
au BufWritePost .vimrc so ~/.vimrc

" Open Geeknote
" noremap <F8> :Geeknote<cr>

" launch ezbar
let g:ezbar_enable   = 1

" ChooseWindow pour choisir vers quel fenêtre se placer
nmap  -  <Plug>(choosewin)



" VimCalendar
let g:calendar_google_calendar = 1

" Envoie directemen mon code sur un pastebin
" Le code sera prive par défaut et le navigateur s'ouvrira
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_post_private = 1
let g:gist_post_anonymous = 1
let g:gist_open_browser_after_post = 1

" Verificateur sybtastic python
let g:syntastic_python_python_exec = 'usr/lib/python3.4'

" SuperTab autocomplete
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview


let g:multi_cursor_start_key='<F6>'

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
