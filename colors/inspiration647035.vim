" Generated by Inspiration at Sweyla
" http://inspiration.sweyla.com/code/seed/647035/

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "inspiration647035"

if version >= 700
  hi CursorLine     guibg=#000606 ctermbg=16
  hi CursorColumn   guibg=#000606 ctermbg=16
  hi MatchParen     guifg=#4A4B51 guibg=#000606 gui=bold ctermfg=239 ctermbg=16 cterm=bold
  hi Pmenu          guifg=#FFFFFF guibg=#323232 ctermfg=255 ctermbg=236
  hi PmenuSel       guifg=#FFFFFF guibg=#8D3DC4 ctermfg=255 ctermbg=98
endif

" Background and menu colors
hi Cursor           guifg=NONE guibg=#FFFFFF ctermbg=255 gui=none
hi Normal           guifg=#FFFFFF guibg=#000606 gui=none ctermfg=255 ctermbg=16 cterm=none
hi NonText          guifg=#FFFFFF guibg=#0F1515 gui=none ctermfg=255 ctermbg=233 cterm=none
hi LineNr           guifg=#FFFFFF guibg=#191F1F gui=none ctermfg=255 ctermbg=234 cterm=none
hi StatusLine       guifg=#FFFFFF guibg=#1C112C gui=italic ctermfg=255 ctermbg=234 cterm=italic
hi StatusLineNC     guifg=#FFFFFF guibg=#282E2E gui=none ctermfg=255 ctermbg=236 cterm=none
hi VertSplit        guifg=#FFFFFF guibg=#191F1F gui=none ctermfg=255 ctermbg=234 cterm=none
hi Folded           guifg=#FFFFFF guibg=#000606 gui=none ctermfg=255 ctermbg=16 cterm=none
hi Title            guifg=#8D3DC4 guibg=NONE	gui=bold ctermfg=98 ctermbg=NONE cterm=bold
hi Visual           guifg=#E2E8FF guibg=#323232 gui=none ctermfg=189 ctermbg=236 cterm=none
hi SpecialKey       guifg=#FF308F guibg=#0F1515 gui=none ctermfg=204 ctermbg=233 cterm=none
"hi DiffChange       guibg=#4C5004 gui=none ctermbg=58 cterm=none
"hi DiffAdd          guibg=#252950 gui=none ctermbg=235 cterm=none
"hi DiffText         guibg=#663569 gui=none ctermbg=241 cterm=none
"hi DiffDelete       guibg=#3F0404 gui=none ctermbg=52 cterm=none
 
hi DiffChange       guibg=#4C4C09 gui=none ctermbg=234 cterm=none
hi DiffAdd          guibg=#252556 gui=none ctermbg=17 cterm=none
hi DiffText         guibg=#66326E gui=none ctermbg=22 cterm=none
hi DiffDelete       guibg=#3F000A gui=none ctermbg=0 ctermfg=196 cterm=none
hi TabLineFill      guibg=#5E5E5E gui=none ctermbg=235 ctermfg=228 cterm=none
hi TabLineSel       guifg=#FFFFD7 gui=bold ctermfg=230 cterm=bold


" Syntax highlighting
hi Comment guifg=#8D3DC4 gui=none ctermfg=98 cterm=none
hi Constant guifg=#FF308F gui=none ctermfg=204 cterm=none
hi Number guifg=#FF308F gui=none ctermfg=204 cterm=none
hi Identifier guifg=#7922FF gui=none ctermfg=93 cterm=none
hi Statement guifg=#4A4B51 gui=none ctermfg=239 cterm=none
hi Function guifg=#8DE13E gui=none ctermfg=113 cterm=none
hi Special guifg=#75007C gui=none ctermfg=90 cterm=none
hi PreProc guifg=#75007C gui=none ctermfg=90 cterm=none
hi Keyword guifg=#4A4B51 gui=none ctermfg=239 cterm=none
hi String guifg=#E2E8FF gui=none ctermfg=189 cterm=none
hi Type guifg=#BD50FF gui=none ctermfg=135 cterm=none
hi pythonBuiltin guifg=#7922FF gui=none ctermfg=93 cterm=none
hi TabLineFill guifg=#5A6069 gui=none ctermfg=59 cterm=none

