" Generated by Inspiration at Sweyla
" http://inspiration.sweyla.com/code/seed/764790/

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "inspiration764790"

if version >= 700
  hi CursorLine     guibg=#080615 ctermbg=232
  hi CursorColumn   guibg=#080615 ctermbg=232
  hi MatchParen     guifg=#911A73 guibg=#080615 gui=bold ctermfg=89 ctermbg=232 cterm=bold
  hi Pmenu          guifg=#FFFFFF guibg=#323232 ctermfg=255 ctermbg=236
  hi PmenuSel       guifg=#FFFFFF guibg=#B23A0C ctermfg=255 ctermbg=130
endif

" Background and menu colors
hi Cursor           guifg=NONE guibg=#FFFFFF ctermbg=255 gui=none
hi Normal           guifg=#FFFFFF guibg=#080615 gui=none ctermfg=255 ctermbg=232 cterm=none
hi NonText          guifg=#FFFFFF guibg=#171524 gui=none ctermfg=255 ctermbg=234 cterm=none
hi LineNr           guifg=#FFFFFF guibg=#211F2E gui=none ctermfg=255 ctermbg=235 cterm=none
hi StatusLine       guifg=#FFFFFF guibg=#2A1013 gui=italic ctermfg=255 ctermbg=233 cterm=italic
hi StatusLineNC     guifg=#FFFFFF guibg=#302E3D gui=none ctermfg=255 ctermbg=236 cterm=none
hi VertSplit        guifg=#FFFFFF guibg=#211F2E gui=none ctermfg=255 ctermbg=235 cterm=none
hi Folded           guifg=#FFFFFF guibg=#080615 gui=none ctermfg=255 ctermbg=232 cterm=none
hi Title            guifg=#B23A0C guibg=NONE	gui=bold ctermfg=130 ctermbg=NONE cterm=bold
hi Visual           guifg=#97600C guibg=#323232 gui=none ctermfg=94 ctermbg=236 cterm=none
hi SpecialKey       guifg=#8804A7 guibg=#171524 gui=none ctermfg=91 ctermbg=234 cterm=none
"hi DiffChange       guibg=#52500E gui=none ctermbg=58 cterm=none
"hi DiffAdd          guibg=#2B295B gui=none ctermbg=236 cterm=none
"hi DiffText         guibg=#6A3572 gui=none ctermbg=242 cterm=none
"hi DiffDelete       guibg=#45040F gui=none ctermbg=52 cterm=none
 
hi DiffChange       guibg=#4C4C09 gui=none ctermbg=234 cterm=none
hi DiffAdd          guibg=#252556 gui=none ctermbg=17 cterm=none
hi DiffText         guibg=#66326E gui=none ctermbg=22 cterm=none
hi DiffDelete       guibg=#3F000A gui=none ctermbg=0 ctermfg=196 cterm=none
hi TabLineFill      guibg=#5E5E5E gui=none ctermbg=235 ctermfg=228 cterm=none
hi TabLineSel       guifg=#FFFFD7 gui=bold ctermfg=230 cterm=bold


" Syntax highlighting
hi Comment guifg=#B23A0C gui=none ctermfg=130 cterm=none
hi Constant guifg=#8804A7 gui=none ctermfg=91 cterm=none
hi Number guifg=#8804A7 gui=none ctermfg=91 cterm=none
hi Identifier guifg=#639E47 gui=none ctermfg=71 cterm=none
hi Statement guifg=#911A73 gui=none ctermfg=89 cterm=none
hi Function guifg=#76717F gui=none ctermfg=243 cterm=none
hi Special guifg=#D87073 gui=none ctermfg=167 cterm=none
hi PreProc guifg=#D87073 gui=none ctermfg=167 cterm=none
hi Keyword guifg=#911A73 gui=none ctermfg=89 cterm=none
hi String guifg=#97600C gui=none ctermfg=94 cterm=none
hi Type guifg=#495E3F gui=none ctermfg=238 cterm=none
hi pythonBuiltin guifg=#639E47 gui=none ctermfg=71 cterm=none
hi TabLineFill guifg=#412A11 gui=none ctermfg=235 cterm=none

