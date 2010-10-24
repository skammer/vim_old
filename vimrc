"------------------------------------------------------------
"
"       _                                             _
"  ___ | | __ __ _  _ __ ___   _ __ ___    ___  _ __ ( )___
" / __|| |/ // _` || '_ ` _ \ | '_ ` _ \  / _ \| '__||// __|
" \__ \|   <| (_| || | | | | || | | | | ||  __/| |     \__ \
" |___/|_|\_\\__,_||_| |_| |_||_| |_| |_| \___||_|     |___/
"
"
"
"
"              __   __(_) _ __ ___   _ __  ___
"              \ \ / /| || '_ ` _ \ | '__|/ __|
"              _\ V / | || | | | | || |  | (__
"             (_)\_/  |_||_| |_| |_||_|   \___|
"
"
"------------------------------------------------------------

"set backspace&

"------------------
" Начальные необходимые настройки
"------------------
set nocompatible
set ruler
set visualbell"
set colorcolumn=85
set textwidth=85
"set wrapmargin=85
"set wrap
set linebreak
set breakat=\ ^I!@*-+;:,./?
set showbreak=>
"set autochdir
set backup            " keep a backup file
set backupdir=~/.vim/backup

set undofile
set undodir=~/.vim/undo


filetype on
filetype plugin on
filetype indent on

syntax on

"------------------
" Внешний вид
"------------------
"colorscheme wombat
"colorscheme tutticolori
"colorscheme github

colorscheme skammer

"Load pathogene
call pathogen#runtime_append_all_bundles()


"set enc=utf8 fileencodings nobomb
"set penc=utf8
set hidden
set shortmess=atI

"set lines=45 columns=130

"set transparency=5
set showcmd
" Нумерация строк
set nu
" Убираем полосы прокрутки, но оставляем клевые табы
set go=amge
"set guioptions-=T
" Люблю пробелы вместо табов. И отступы по 2 пробела
set autoindent
set smartindent
set cindent
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

" Просто неплохие шрифты

"set guifont=DejaVu\ Sans\ Mono:h10
"set guifont=Andale\ Mono:h11
"set guifont=Menlo\ Regular:h11
"set guifont=Monaco:h11
"set guifont=Mensch:h11

" Шрифт для варианта без сглаживания
"set guifont=Terminus:h15
set guifont=Anonymous\ Pro:h12
"set noanti

" Шрифт, кода я использую сглаживание
"set guifont=Liberation\ Mono:h11
"set anti
set scrolloff=3
"set cursorline
set ignorecase
set smartcase
set gdefault
set showmatch

"set gcr=i:block

"" Highligth in red more then 80 columns

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.*/


" Display extra whitespace
nmap <localleader>l :set list!<cr>
set list
"set listchars=tab:~·,trail:·
set listchars=tab:▸\ ,trail:·,eol:¬


let g:ruby_debugger_progname = 'mvim'

let g:DrChipTopLvlMenu = "Plugin."
"let s:C_Root = "Plugin.C\/C\+\+."

"--------------------------------------------------
"                 Строка состояния
"--------------------------------------------------

set laststatus=2

" Строка под комментрарием может пригодиться, если пользоваться twitvim. Тогда
" можно будет посмотреть сколько символов в текущей строке.

"set statusline=%<%{&ff}\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%t\ %{GitBranchInfoString()}\ %Y\ %n\ %m%r%h%w\ %=%{CountLettersInCurrentLine()}\ %03p%%\ [%04l,%04v]\ %L
"-------------------------------------------------


"set statusline=%<%{&ff}\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%t\ %Y\ %n\ %m%r%h%w\ %{fugitive#statusline()}\ %=%{CountLettersInCurrentLine()}\ %03p%%\ [%04l,%04v]\ %L

set statusline=%<%{&ff}\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%t\ %Y\ %n\ %m%r%h%w\ %{fugitive#statusline()}\ %=%03p%%\ [%04l,%04v]\ %L

"Git-branch-info stuff
let g:git_branch_status_head_current=1
let g:git_branch_status_nogit="no_git"
let g:git_branch_status_ignore_remotes=1
let g:git_branch_status_text="branch:"

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


"--------------------------------------------------
"            Настройки ввода и шорткаты
"--------------------------------------------------

set backspace=indent,eol,start

let mapleader="."
let maplocalleader='\'

" Быстрый и простой make
if filereadable("Makefile")
  set makeprg = make\ -j
  map <C-b> :cd %:p:h<cr>:make<CR>:cw<CR>
else
  map <C-b> :make %:r<CR>:cw<CR>
endif

"map ,s :source %<CR>
"map ,t :TMiniBufExplorer<CR>

"map <Tab> :call ZenCodingTabExpander()

map <leader>nt :NERDTreeToggle<CR>
map <leader>tl :TlistToggle<CR>
map <leader>ed :e $MYVIMRC<CR>
map <leader>rv :source $MYVIMRC<CR>
map <leader>o :only<CR>
map <leader>vsp :vsp<cr>
map <leader>sp :sp<CR>
"map <C-f> zc
"map <C-d> zo
"unfold folded code
"noremap <D-d> za
imap <silent> <D-d> <Esc>za
vmap <silent> <D-d> za
nmap <silent> <D-d> za


imap <silent> <D-/> <Esc>,c<Space>a
vmap <silent> <D-/> ,c<Space>
nmap <silent> <D-/> V,c<Space>

"--------------------------------------------------
" TODO Desperateky needs some rework!!!
"-------------------------------------------------- 

imap <D-]> <Esc>mX>>`X2la
"vmap <D-]> ><D-Right>
vmap <D-]> >gv
nmap <D-]> mX>>`X2l

"vnoremap < <gv
"vnoremap > >gv

imap <silent> <D-[> <Esc>mX<<`X2ha
"vmap <silent> <D-[> <<D-Right>
vmap <silent> <D-[> <gv
nmap <silent> <D-[> mX<<`X2h


imap <D-e> <Esc>:CommandT<CR>
nmap <D-e> <Esc>:CommandT<CR>

"map to bufexplorer
nnoremap <leader>buf :BufExplorer<cr>
imap <D-Enter> <Esc>o
imap <D-S-Enter> <Esc>O

" Рубинистические всякие вкусности

" plain annotations
map <silent> <D-r> !xmpfilter -a<cr>
nmap <silent> <D-r> V<D-r>
imap <silent> <D-r> <ESC><D-r>a

" Annotate the full buffer
" I actually prefer ggVG to %; it's a sort of poor man's visual bell
nmap <silent> <D-R> mzggVG!xmpfilter -a<cr>'z
imap <silent> <D-R> <ESC><D-R>

" assertions
nmap <silent> <C-D-r> mzggVG!xmpfilter -u<cr>'z
imap <silent> <C-D-r> <ESC><C-D-r>a

" Add # => markers
vmap <silent> <localleader>a3 !xmpfilter -m<cr>
nmap <silent> <localleader>a3 V<localleader>a3
imap <silent> <localleader>a3 <ESC><localleader>a3a

" Remove # => markers
vmap <silent> <localleader>r3 ms:call RemoveRubyEval()<CR>
nmap <silent> <localleader>r3 V<localleader>r3
imap <silent> <localleader>r3 <ESC><localleader>r3a

map ,t <Plug>TaskList

" No Help, please
"nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

function! RemoveRubyEval() range
  let begv = a:firstline
  let endv = a:lastline
  normal Hmt
  set lz
  execute ":" . begv . "," . endv . 's/\s*# \(=>\|!!\).*$//e'
  normal 'tzt`s
  set nolz
  redraw
endfunction

"set invfullsreen

let g:is_fulscreen = 0
fu! ToggleFullscreen()
  if g:is_fulscreen == 0
    let g:old_lines=&lines
    let g:old_columns=&columns
    set go-=e
    set lines=999
    set columns=999
    set invfullscreen
    let g:is_fulscreen = 1
  else
    set go+=e
    exec 'set columns='.g:old_columns
    exec 'set lines='.g:old_lines
    set invfullscreen
    let g:is_fulscreen = 0
  endif
endf

imap <D-D> <Esc>:call ToggleFullscreen()<cr>a
vmap <D-D> ms:call ToggleFullscreen()<cr>
nmap <D-D> v<D-D>

function! CapitalizeCenterAndMoveDown()
   s/\<./\u&/g   "Built-in substitution capitalizes each word
   center        "Built-in center command centers entire line
   +1            "Built-in relative motion (+1 line down)
endfunction

nmap <silent>  \C  :call CapitalizeCenterAndMoveDown()<CR>


map <S-D-Left> :bp<cr>
map <S-D-Right> :bn<cr>
imap <S-D-Left> <ESC>:bp<cr>
imap <S-D-Right> <ESC>:bn<cr>

"noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
"noremap <c-s-down> ddp

"noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
"noremap <silent> <c-s-down> :call <SID>swap_down()<CR>

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
let Tlist_Use_Right_Window = 1

"let g:fuzzy_matching_limit = 40

let g:CommandTMaxFiles=20000


let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

"------------------
" Настройки, ещё не проверенные
"------------------

augroup filetypedetect
  au! BufNewFile,BufRead *.ch     setf        cheat
  au! BufNewFile,BufRead *.liquid setf        liquid
  au! BufRead,BufNewFile *.haml   setfiletype haml
  au! BufNewFile,BufRead *.yml    setf        eruby
  au! BufRead,BufNewFile *.vm     set         filetype=velocity
  au! BufRead,BufNewFile *.less   set         syntax=less       filetype=less      expandtab
  au! BufRead,BufNewFile *.b      set         syntax=brainfuck  filetype=brainfuck
  au! BufRead,BufNewFile *.tab    set         syntax=chords     filetype=chords
  au! BufRead,BufNewFile *.coffee set         syntax=coffee     filetype=coffee
  au! BufRead,BufNewFile *.4th    set         syntax=forth      filetype=forth
  au! BufRead,BufNewFile *.4mu    set         syntax=forth      filetype=forth
  au! BufRead *.log set autoread filetype=conf
augroup END

autocmd BufRead *.java,*.c,*.h,*.cc set formatoptions=tcroq cindent comments=sr:/**,mb:*,elx:*/,sr:/*,mb:*,elx:*/,://

autocmd BufNewFile,BufRead *_test.rb source ~/.vim/ftplugin/shoulda.vim


autocmd! bufwritepost ~/.vimrc execute "normal! :source ~/.vimrc"

autocmd FileType python        set omnifunc=pythoncomplete#Complete
autocmd FileType javascript    set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html          set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css           set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml           set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php           set omnifunc=phpcomplete#CompletePHP
autocmd FileType c             set omnifunc=ccomplete#Complete
autocmd FileType velocity      set syntax=velocity
autocmd FileType ruby,perl,tex set shiftwidth=2

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

"au BufNewFile,BufRead *.todo set filetype=todo


" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim


"--------------------------------------------------
"               folding settings
"--------------------------------------------------

if has("folding")
 "set foldmethod=indent   "fold based on indent
 " Гадкая какашка :(
 set foldenable
 set foldmethod=syntax
 set foldnestmax=5       "deepest fold

 set foldlevel=99
 "set foldcolumn=3
 set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

set wildmode=list:longest,full   "make cmdline tab completion similar to bash
set wildmenu                     "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~      "stuff to ignore when tab completing

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
      \ laborum.


"=================================="

" TwitVim related stuff
fu! LoginTwitter()
  let a:user=input("Your twitter login: ")
  let a:pswd=inputsecret(a:user."'s password: ")
  let g:twitvim_login=a:user.':'.a:pswd
  echo "Credentials are saved"
endf

"let twitvim_enable_ruby = 1

command! Twil :call LoginTwitter()
"twittervim mappings
nmap <C-f>p :PosttoTwitter<cr>
nmap <C-f>f :FriendsTwitter<cr>
nmap <C-f>l :Twil<cr>
nmap <C-f>b :BPosttoTwitter<cr>
nmap <C-f>r :RefreshTwitter<cr>


" Мне можно сделать и больше. Часов за 5 успевает навалиться полторы сотни.
let twitvim_count = 100

" Настройки для acp

let g:acp_enableAtStartup = 0
let g:acp_behaviorKeywordLength = 3

"let g:rgbtxt="$HOME/.vim/rgb.txt"
"let g:running_RefreshColors=1

let g:vimwiki_use_mouse  = 1
let g:vimwiki_folding    = 1
let g:vimwiki_fold_lists = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_auto_checkbox = 1
let wiki = {}
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c': 'C', 'ruby': 'Ruby', 'haml': 'Haml'}
let vimwiki_list = [wiki]



fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

command! StripTrailingWhitespaces :call StripTrailingWhitespaces()

fun! Beautify()
  retab
  call StripTrailingWhitespaces()
endf

command! Beautify :call Beautify()

imap <C-D-t> <C-O>:call Toggle()<CR>
nmap <C-D-t> :call Toggle()<CR>
vmap <C-D-t> <ESC>:call Toggle()<CR>

let g:rsenseUseOmniFunc = 0
let g:rsenseHome = "/Users/skammer/rep/rsense/"

set grepprg=ack

"--------------------------------------------------
" Маппим кириллические символы
"--------------------------------------------------
map ё ´
map й j
map ц c
map у u
map к k
map е e
map н n
map г g
map ш w
map щ `
map з z
map х x
map ъ =
map ф f
map ы y
map в v
map а a
map п p
map р r
map о o
map л l
map д d
map ж ]
map э \
map я q
map ч h
map с s
map м m
map и i
map т t
map ь -
map б b
map ю [

map Ё ´
map Й J
map Ц C
map У U
map К K
map Е E
map Н N
map Г G
map Ш W
map Щ `
map З Z
map Х X
map Ъ =
map Ф F
map Ы Y
map В V
map А A
map П P
map Р R
map О O
map Л L
map Д D
map Ж ]
map Э \
map Я Q
map Ч H
map С S
map М M
map И I
map Т T
map Ь -
map Б B
map Ю [

let g:sparkupNextMapping = '<c-l>'
let g:sparkupExecuteMapping = '<c-E>'

map <leader>ss ?{<CR>jV/^\s*\}\=$<CR>k:sort<CR>:let @/=''<CR>


"Neocomplpop

" Use neocomplcache. 
let g:NeoComplCache_EnableAtStartup = 1 
" Use smartcase. 
let g:NeoComplCache_SmartCase = 1 
" Use camel case completion. 
"let g:NeoComplCache_EnableCamelCaseCompletion = 1 
" Use underbar completion. 
let g:NeoComplCache_EnableUnderbarCompletion = 1 
" Set minimum syntax keyword length. 
let g:NeoComplCache_MinSyntaxLength = 3 
" Set manual completion length. 
let g:NeoComplCache_ManualCompletionStartLength = 0 
" Set minimum keyword length. 
let g:NeoComplCache_MinKeywordLength = 3 

map <F6> :vimgrep /fixme\\|todo/j *.[c,cpp,h,hpp,py]<CR>:cw<CR>

let g:defaultInputSourceIndex = 0
let g:kls_focusSwitching = 1
let g:kls_tabSwitching = 0

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Use the damn hjkl keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <leader>w <C-w>v<C-w>l


