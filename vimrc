"------------------
" Начальные необходимые настройки
"------------------
set nocompatible
set ruler
set visualbell"

filetype on
filetype plugin on
filetype indent on

"------------------
" Внешний вид
"------------------
colorscheme wombat
syntax on

set hidden
set shortmess=atI
set lines=35 columns=120
set transparency=5
set showcmd
" Нумерация строк
set nu
" Убираем полосы прокрутки, но оставляем клевые табы
set guioptions-=T
set guioptions=amge
" Люблю пробелы вместо табов. И отступы по 2 пробела
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" Штуки с поиском
set hlsearch
set incsearch
set showmatch
set background=dark
set imd

"set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)

" Строка состояния P.S. надо сделать более информативной
set laststatus=2
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P

set statusline=%<%{&ff}\ %f\ %Y\ %n\ %{CountLettersInCurrentLine()}\ %{CountLettersInCurrentBuffer()}\ %=%03p%%\ [%04l,%04v]\ %L

fu! CountLettersInCurrentLine()
  let string = StrLen(getline("."))
  return string
endf

fu! CountLettersInCurrentBuffer()
  let lines = getbufline(bufnr(bufname("%")), 1, "$")
  let number = 0
  for item in lines
    let number += StrLen(item)
  endfor
  return number
endfu

function! StrLen(str)
  "call s:Debug("StrLen", "StrLen returned: ".strlen(substitute(a:str, '.', 'x', 'g'))." based on this text: ".a:str)
  return strlen(substitute(a:str, '.', 'x', 'g'))
endfunction


"------------------
" Настройки ввода и шорткаты
"------------------
set backspace=indent,eol,start

let mapleader="."
let maplocalleader="\"

" Быстрый и простой make
if filereadable("Makefile")
	set makeprg = make\ -j
	map <C-b> :make<CR>:cw<CR>
else
	map <C-b> :make %:r<CR>:cw<CR>
endif


"map ,s :source %<CR>
"map ,t :TMiniBufExplorer<CR>

map <leader>nt :NERDTreeToggle<CR>
map <leader>tl :TlistToggle<CR>
map <leader>ed :e $MYVIMRC<CR>
map <leader>o :only<CR>
map <leader>vsp :vsp<cr>
map <leader>sp :sp<CR>
map <C-f> zc "fold code
map <C-d> zo "unfold folded code

nnoremap <c-t>t :FuzzyFinderTextMate<CR>
"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>


" Настройки завершения скобок
"--------------------------------------------------
" inoremap {  {}<Left>
" inoremap {<Space>     {
" inoremap {}     {}
" 
" inoremap [      []<Left>
" inoremap [<Space>     [
" inoremap []     []
" 
" inoremap          (   ()<LEFT>
" inoremap <silent> )   )<Esc>
"                       \:let tmp0=&clipboard <BAR>
"                       \let &clipboard=''<BAR>
"                       \let tmp1=@"<BAR>
"                       \let tmp2=@0<CR>
"                       \y2l
"                       \:if '))'=="<C-R>=escape(@0,'"\')<CR>"<BAR>
"                       \  exec 'normal "_x'<BAR>
"                       \endif<BAR>
"                       \let @"=tmp1<BAR>
"                       \let @0=tmp2<BAR>
"                       \let &clipboard=tmp0<BAR>
"                       \unlet tmp0<BAR>
"                       \unlet tmp1<BAR>
"                       \unlet tmp2<CR>
"                       \a
" 
" inoremap '      ''<Left>
" inoremap '<Space> '
" inoremap ''     ''
" 
" inoremap "      ""<Left>
" inoremap "<Space> "
" inoremap ""     ""
" 
"-------------------------------------------------- 
"------------------
" Настройки плагинов
"------------------
let NERDTreeShowHidden=0

" Minibuffer Explorer Settings
"let g:miniBufExplorerMoreThanOne=0
"let g:miniBufExplUseSingleClick=1
"let g:miniBufExplModSelTarget=1
"let g:miniBuExplSplitToEdge=0
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1

let Tlist_Ctags_Cmd="/opt/local/bin/ctags"

let g:fuzzy_matching_limit = 70

"------------------
" Настройки, ещё не проверенные
"------------------

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,perl,tex set shiftwidth=2

augroup filetypedetect
  au! BufNewFile,BufRead *.ch setf cheat
  au BufNewFile,BufRead *.liquid setf liquid
  au! BufRead,BufNewFile *.haml setfiletype haml
  autocmd BufNewFile,BufRead *.yml setf eruby
augroup END

autocmd BufNewFile,BufRead *_test.rb source ~/.vim/ftplugin/shoulda.vim

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim


"folding settings
set foldmethod=syntax  "fold based on indent
set foldnestmax=5       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest,full   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction

command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum


" TwitVim related stuff
fu! LoginTwitter()
let a:user=input("Your twitter login: ")
let a:pswd=inputsecret(a:user."'s password: ")
let g:twitvim_login=a:user.':'.a:pswd
echo "Credentials are saved"
endf
command! Twil :call LoginTwitter()
"twittervim mappings
nmap <C-t>p :PosttoTwitter<cr>
nmap <C-t>f :FriendsTwitter<cr>
nmap <C-t>l :Twil<cr>
nmap <C-t>b :BPosttoTwitter<cr>

let g:AutoComplPop_CompleteoptPreview = 0
let g:AutoComplPop_MappingDriven = 1
