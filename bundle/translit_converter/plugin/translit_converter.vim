" translit_converter.vim -- convert transliterated text (russian)
" plugin for Vim version 7.0 and above
" Home: http://www.vim.org/scripts/script.php?script_id=2725
" Author: Vlad Irnov  (vlad DOT irnov AT gmail DOT com)
" Version: 1.1, 2009-12-24
" this file is in utf-8 encoding
"
"--- docs ---{{{1
"  DESCRIPTION
"  ===========
"  This plugin creates commands for converting from and to Russian translit
"  using utf-8 encoding. For example, to write "Чебурашка", write
"  "Cheburashka" or "CHeburashka", select the word and execute command
"  ":Torus v" .
"
"  Similar plugins:
"  http://www.vim.org/scripts/script.php?script_id=2401
"  http://www.vim.org/scripts/script.php?script_id=2469
"
"
"  USAGE
"  =====
"  This plugin creates two commands: Torussian and Fromrussian.
"
"  :[range]Torussian [v]
"            convert from translit (latin alphabet) to Russian (utf-8)
"  :[range]Fromrussian [v]
"            convert from Russian (utf-8) to translit
"
"  These can be used as follows (commands can be abbreviated):
"
"  :Torus
"            Convert current line.
"
"  :'<,'>Torus
"            Convert lines in Visual range. Any other range can be specified,
"            for example :%Torus will convert entire buffer.
"
"  :Torus v
"  :'<,'>Torus v
"            Convert text in Visual area. If a range is specified, it is
"            ignored.
"
"
"  CUSTOMIZING
"  ===========
"  If you don't like my transliteration version, edit s:table_ru.
"
"  It is easy to add converters for other alphabets.
"  First, create conversion table:
"     let s:table_greek = [ ..... ]
"
"  And then add new commands:
"     com! -range -nargs=? Togreek   call s:Translit_Converter(<line1>,<line2>, 'table_greek', 0,1, <q-args>)
"     com! -range -nargs=? Fromgreek call s:Translit_Converter(<line1>,<line2>, 'table_greek', 1,0, <q-args>)
"
"
"  INSTALLATION
"  ============
"  Source the script or put it in your local plugin folder:
"   ~/.vim/plugin/  or  $HOME\vimfiles\plugin\


"--- Quickload ---{{{1
if !exists('s:translit_converter_did_load')
    let s:translit_converter_did_load = 1
    com! -range -nargs=? Torussian   call s:Translit_Converter(<line1>,<line2>, 'table_ru', 0,1, <q-args>)
    com! -range -nargs=? Fromrussian call s:Translit_Converter(<line1>,<line2>, 'table_ru', 1,0, <q-args>)
    exe "au FuncUndefined *Translit_Converter source " . expand("<sfile>:p")
    finish
endif

au! FuncUndefined *Translit_Converter
let s:cpo_save = &cpo
set cpo&vim

"--- s:table_ru ---{{{1
" This table is slightly different from usual translit versions. It is designed
" so that any arbitrary sequence of Russian letters could be represented
" unambiguously by Latin letters. Most importantly, 'y/Y' and 'h/H' don't
" encode anything by themselves.
"
" order is important--doubles must be replaced first
" move xh after shh to replace щ with shh instead of with xh
let s:table_ru = [
\   ['YO' ,       'Ё'],
\   ['YU' ,       'Ю'],
\   ['YA' ,       'Я'],
\   ['EH' ,       'Э'],
\   ['ZH' ,       'Ж'],
\   ['CH' ,       'Ч'],
\   ['XH' ,       'Щ'],
\   ['SHH' ,      'Щ'],
\   ['SH' ,       'Ш'],
\   ['X' ,        'Х'],
\   ['KH' ,       'Х'],
\   ['QH' ,       'Ъ'],
\
\   ['Yo' ,       'Ё'],
\   ['Yu' ,       'Ю'],
\   ['Ya' ,       'Я'],
\   ['Eh' ,       'Э'],
\   ['Zh' ,       'Ж'],
\   ['Ch' ,       'Ч'],
\   ['Xh' ,       'Щ'],
\   ['Shh' ,      'Щ'],
\   ['Sh' ,       'Ш'],
\   ['Kh' ,       'Х'],
\   ['Qh' ,       'Ъ'],
\
\   ['Q' ,        'Ь'],
\   ['A' ,        'А'],
\   ['B' ,        'Б'],
\   ['V' ,        'В'],
\   ['G' ,        'Г'],
\   ['D' ,        'Д'],
\   ['E' ,        'Е'],
\   ['Z' ,        'З'],
\   ['I' ,        'И'],
\   ['J' ,        'Й'],
\   ['K' ,        'К'],
\   ['L' ,        'Л'],
\   ['M' ,        'М'],
\   ['N' ,        'Н'],
\   ['O' ,        'О'],
\   ['P' ,        'П'],
\   ['R' ,        'Р'],
\   ['S' ,        'С'],
\   ['T' ,        'Т'],
\   ['U' ,        'У'],
\   ['F' ,        'Ф'],
\   ['C' ,        'Ц'],
\   ['W' ,        'Ы'],
\
\   ['yo' ,       'ё'],
\   ['yu' ,       'ю'],
\   ['ya' ,       'я'],
\   ['eh' ,       'э'],
\   ['zh' ,       'ж'],
\   ['ch' ,       'ч'],
\   ['xh' ,       'щ'],
\   ['shh' ,      'щ'],
\   ['sh' ,       'ш'],
\   ['x' ,        'х'],
\   ['kh' ,       'х'],
\   ['qh' ,       'ъ'],
\   ['q' ,        'ь'],
\   ['a' ,        'а'],
\   ['b' ,        'б'],
\   ['v' ,        'в'],
\   ['g' ,        'г'],
\   ['d' ,        'д'],
\   ['e' ,        'е'],
\   ['z' ,        'з'],
\   ['i' ,        'и'],
\   ['j' ,        'й'],
\   ['k' ,        'к'],
\   ['l' ,        'л'],
\   ['m' ,        'м'],
\   ['n' ,        'н'],
\   ['o' ,        'о'],
\   ['p' ,        'п'],
\   ['r' ,        'р'],
\   ['s' ,        'с'],
\   ['t' ,        'т'],
\   ['u' ,        'у'],
\   ['f' ,        'ф'],
\   ['c' ,        'ц'],
\   ['w' ,        'ы']
\                   ]


func! s:Translit_Converter(lnum1, lnum2, table, from, to, what) "{{{1
    let table = s:{a:table}

    " no argument given, convert lines
    if a:what==''
        for pair in table
            silent exe a:lnum1.','.a:lnum2.'s/\C\V'.pair[a:from].'/'.pair[a:to].'/ge'
        endfor

    " convert text in Visual area: copy to register, substitute, paste over
    " pasting into visual selection changes " register (:help v_p)
    elseif a:what==#'v'
        "if line("'<")==0 || line("'>")==0
        if visualmode()==''
            echo "translit_converter: Visual region doesn't exist"
            return
        endif
        let reg_unnamed = getreg('"')
        let reg_unnamed_mode = getregtype('"')
        let reg_z = getreg('z')
        let reg_z_mode = getregtype('z')

        normal! gv"zy

        for pair in table
            let @z = substitute(@z, '\C\V'.pair[a:from], pair[a:to], 'g')
        endfor

        if visualmode()==#'v'
            call setreg('z', '', 'ac')
        elseif visualmode()==#''
            call setreg('z', '', 'ab')
        endif

        normal! gv"zp

        call setreg('"', reg_unnamed, reg_unnamed_mode)
        call setreg('z', reg_z, reg_z_mode)

    else
        echo 'translit_converter: command argument should be "v"'
    endif
endfunc


"--- restore cpo ---{{{1
let &cpo = s:cpo_save
unlet s:cpo_save

