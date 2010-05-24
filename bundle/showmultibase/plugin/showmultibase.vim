" ========================================================================== "
" Name:        showmultibase                                                 "
" Version:     0.1                                                           "
" Updated:     2010-04-20 23:59:52                                           "
" Description: Displays the number specified or under the cursor in binary,  "
"                octal, decimal and hexadecimal form.                        "
"                It also provides some conversion functions: {2,8,16}<->10   "
" Author:      Lajos Zaccomer <lajos AT zaccomer DOT org br>                 "
" Credits:     lilydjwg <lilydjwg AT gmail DOT com>                          "
"                Author of rfc.vim (vimscript #2930), source of              "
"                get_pattern_at_cursor().                                    "
"              Michael Geddes                                                "
"                Author of hex.vim (vimscript #238), source of Dec2Hex()     "
" ========================================================================== "


"
" Configuration
"

" If set to 1, the default keymaps will be created. Otherwise, set this to 0
" in your vimrc and define the mappings according to your taste!
if !exists("g:ShowMultiBase_UseDefaultMappings")
  let g:ShowMultiBase_UseDefaultMappings = 1
endif
if !exists("g:ShowMultiBase_DisplayBin")
  let g:ShowMultiBase_DisplayBin = 1
endif
if !exists("g:ShowMultiBase_DisplayOct")
  let g:ShowMultiBase_DisplayOct = 1
endif
if !exists("g:ShowMultiBase_DisplayDec")
  let g:ShowMultiBase_DisplayDec = 1
endif
if !exists("g:ShowMultiBase_DisplayHex")
  let g:ShowMultiBase_DisplayHex = 1
endif
" The number of binary digits that shall be displayed next to each other
" without inserting any separating space in between them. The digit blocks of
" this size are separated with a single space.
if !exists("g:ShowMultiBase_SegmentBin")
  let g:ShowMultiBase_SegmentBin = 4
endif
" The number of hexadecimal digits that shall be displayed next to each other
" without inserting any separating space in between them. The digit blocks of
" this size are separated with a single space.
if !exists("g:ShowMultiBase_SegmentHex")
  let g:ShowMultiBase_SegmentHex = 4
endif
" If set to 1, binary numbers shall be displayed with a 'b' prefix, octal
" numbers with '0' prefix and hexadecimal numbers with '0x' prefix.
" The ShowMultiBase_UseCapital flag affects the case of the prefixes, too.
if !exists("g:ShowMultiBase_UsePrefix")
  let g:ShowMultiBase_UsePrefix = 1
endif
" If set to 1, the numbers will be displayed with upper case. This only
" affects the binary and hexadecimal prefixes and the hexadecimal A-F digits.
if !exists("g:ShowMultiBase_UseCapital")
  let g:ShowMultiBase_UseCapital = 0
endif
" If set to 1, leading zeros shall be prepended to the displayed number to fill
" the specified segment size. E.g, if the binary segment size is 4, and the
" binary result is 10, the displayed number is 0010.
if !exists("g:ShowMultiBase_FillSegment")
  let g:ShowMultiBase_FillSegment = 1
endif
" The separator between the displayed numbers. It may contain the new line
" character to display the potentially long numbers in separate lines.
if !exists("g:ShowMultiBase_DisplaySeparator")
  let g:ShowMultiBase_DisplaySeparator = " == "
endif
" If set to 1, the autosense will set the base of numbers containing only 0
" and 1 digits to 2. Otherwise, the base shall be 8 if the first digit is 0
" and 10 in all other cases.
if !exists("g:ShowMultiBase_Only01Binary")
  let g:ShowMultiBase_Only01Binary = 0
endif



"
" Mappings
"
command -nargs=* ShowMultiBase :call ShowMultiBase(<f-args>)

if g:ShowMultiBase_UseDefaultMappings == 1
  noremap <silent> \= :ShowMultiBase<CR>
  noremap <silent> \b= :ShowMultiBase 2<CR>
  noremap <silent> \o= :ShowMultiBase 8<CR>
  noremap <silent> \d= :ShowMultiBase 10<CR>
  noremap <silent> \h= :ShowMultiBase 16<CR>
endif



"
" Script variables
"

let s:hexdig='0123456789abcdef'



"
" The main function
"

function! ShowMultiBase(...)
  let l:nbin = ''
  let l:noct = ''
  let l:ndec = ''
  let l:nhex = ''
  let l:base = 0 " invalid: it must be autosensed
  if (a:0 > 0)
    let l:base = a:1
  endif

  if (a:0 < 2)
    let l:n = s:get_pattern_at_cursor('\(b\|0\+\|0x\)\?\x\+')
    if (l:n == "")
      echohl WarningMsg |
        echo "There is no number under the cursor!" |
      echohl None
      return
    endif
  else
    let l:n = a:2
  endif

  " all the conversions happen with lower case
  let l:n = substitute(l:n, "\\u", "\\l&", "g")

  " If the base is set by the caller, perform sanity check on the number!
  " If the number and the base do not match, print a message and continue
  " with autosensing the base.
  let l:base_error = 0
  if l:base == 2
    if match(l:n, '^b\?1[01]\+$') == -1
      let l:base_error = 1
    else
      let l:nbin = l:n
    endif
  elseif l:base == 8
    if match(l:n, '^[0-7]\+$') == -1
      let l:base_error = 1
    else
      let l:noct = l:n
    endif
  elseif l:base == 10
    if match(l:n, '^[0-9]\+$') == -1
      let l:base_error = 1
    else
      let l:ndec = l:n
    endif
  elseif l:base == 16
    if match(l:n, '^\(0[xX]\)\?\x\+$') == -1
      let l:base_error = 1
    else
      let l:nhex = l:n
    endif
  elseif l:base != 0
    echohl WarningMsg |
      echo "This base is not supported. Use 2, 8, 10 or 16!" |
    echohl None
    let l:base_error = 1
  endif

  if l:base == 0 || l:base_error == 1
    " base not known, autosense
    let l:given_base = l:base
    if match(l:n, '^b[01]\+$') == 0
    \ || (g:ShowMultiBase_Only01Binary == 1 && match(l:n, '^[01]\+$') == 0)
      let l:base = 2
      let l:nbin = l:n
    elseif match(l:n, '^[0-9]\+$') == 0
      let l:base = 10
      let l:ndec = l:n
    elseif match(l:n, '^\(0[xX]\)\?\x\+$') == 0
      let l:base = 16
      let l:nhex = l:n
    elseif match(l:n, '^0[0-7]\+$') == 0
      let l:base = 8
      let l:noct = l:n
    else
      echoerr "@DEV: This should not happen, "
              \"improve the number regexp to avoid getting here!"
      return
    endif

    if l:base_error == 1
      echohl WarningMsg |
        echo "The selected number cannot have base " . given_base
        \ . "! The autoselected base is " . l:base . "." |
      echohl None
    endif
  endif

  " base is now known, remove possible prefix
  let l:n = s:clean_number(l:n)
  let l:nbin = s:clean_number(l:nbin)
  let l:noct = s:clean_number(l:noct)
  let l:ndec = s:clean_number(l:ndec)
  let l:nhex = s:clean_number(l:nhex)

  " Convert to decimal first
  if (l:base != 10)
    let l:ndec = Base2Dec(l:n, l:base)
  endif

  " Convert to octal
  if (l:base != 8)
    let l:noct = Dec2Oct(l:ndec)
  endif

  " Convert to binary
  if (l:base != 2)
    let l:nbin = Dec2Bin(l:ndec)
    let l:nbin = substitute(l:nbin, '^ ', '', '')
  endif

  " Convert to hex
  if (l:base !=16)
    let l:nhex = Dec2Hex(l:ndec)
    let l:nhex = substitute(l:nhex, '^ ', '', '')
  endif

  " Display the configured bases
  let l:display = ''
  let l:separator = ''
  let l:prefix = ''

  if g:ShowMultiBase_DisplayBin == 1 || l:base == 2
    if g:ShowMultiBase_UsePrefix == 1
      let l:prefix = 'b'
    endif
    let l:display = l:prefix . l:nbin
    let l:separator = g:ShowMultiBase_DisplaySeparator
  endif

  if g:ShowMultiBase_DisplayOct == 1 || l:base == 8
    if g:ShowMultiBase_UsePrefix == 1
      let l:prefix = '0'
    endif
    let l:display = l:display . l:separator . l:prefix . l:noct
    let l:separator = g:ShowMultiBase_DisplaySeparator
  endif

  if g:ShowMultiBase_DisplayDec == 1 || l:base == 10
    let l:display = l:display . l:separator . l:ndec
    let l:separator = g:ShowMultiBase_DisplaySeparator
  endif

  if g:ShowMultiBase_DisplayHex == 1 || l:base == 16
    if g:ShowMultiBase_UsePrefix == 1
      let l:prefix = '0x'
    endif
    let l:display = l:display . l:separator . l:prefix . l:nhex
  endif

  if g:ShowMultiBase_UseCapital == 1
    let l:display = substitute(l:display, "\\l", "\\u&", "g")
  endif

  echo l:display

endfunction " ShowMultiBase



"
" Utility functions
"

function! s:get_pattern_at_cursor(pat)
  let col = col('.') - 1
  let line = getline('.')
  let ebeg = -1
  let cont = match(line, a:pat, 0)
  while (ebeg >= 0 || (0 <= cont) && (cont <= col))
    let contn = matchend(line, a:pat, cont)
    if (cont <= col) && (col < contn)
      let ebeg = match(line, a:pat, cont)
      let elen = contn - ebeg
      break
    else
      let cont = match(line, a:pat, contn)
    endif
  endwh
  if ebeg >= 0
    return strpart(line, ebeg, elen)
  else
    return ""
  endif
endfunction


function! Dec2Hex(number)
  let s = 0 " segment counter
	let no=a:number
	let result=''
	while no>0
		let result=s:hexdig[no%16].result
		let no=no/16
    let s = s + 1
    if (s == g:ShowMultiBase_SegmentHex)
      let result = ' ' . result
      let s = 0
    endif
	endwhile

  if g:ShowMultiBase_FillSegment == 1 && s > 0
    while s < g:ShowMultiBase_SegmentHex
      let result = '0' . result
      let s = s + 1
    endwhile
  endif

  if result == ''
    let result = '0'
  endif

	return result
endfunction


function! Hex2Dec(number)
  let result = 0
  let pos = 0
  while pos < strlen(a:number)
    let x = strpart(a:number, pos, 1)
    let d = match(s:hexdig, x)
    let result = result * 16 + d
    let pos = pos + 1
  endwhile
  return result
endfunction


function! Dec2Bin(number)
  let s = 0 " segment counter
  let n = a:number
  let result = ''
  while n > 0
    if (match(n, '[13579]$') != -1) " odd
      let result = '1' . result
    else " even
      let result = '0' . result
    endif
    let n = n / 2
    let s = s + 1
    if (s == g:ShowMultiBase_SegmentBin)
      let result = ' ' . result
      let s = 0
    endif
  endwhile

  if g:ShowMultiBase_FillSegment == 1 && s > 0
    while s < g:ShowMultiBase_SegmentBin
      let result = '0' . result
      let s = s + 1
    endwhile
  endif

  if result == ''
    let result = '0'
  endif

  return result
endfunction


" Convert any base = [2-16] to decimal
function! Base2Dec(number, base)
  let result = 0
  let pos = 0
  while pos < strlen(a:number)
    let x = strpart(a:number, pos, 1)
    let d = match(s:hexdig, x)
    let result = result * a:base + d
    let pos = pos + 1
  endwhile
  return result
endfunction


function! Dec2Oct(number)
  let n = a:number
  let result = ''
  while n > 0
    let result = n % 8 . result
    let n = n / 8
  endwhile
  if result == ''
    let result = '0'
  endif
  return result
endfunction


function! s:clean_number(num)
  " Binary:      b....
  " Octal:       0....
  " Decimal:     .....
  " Hexadecimal: 0x...
  " I.e. remove any 0,b,x characters from the front
  let l:number = substitute(a:num, '^b', '', '')
  let l:number = substitute(l:number, '^0[xX]', '', '')
  let l:number = substitute(l:number, '^0+[^0]$', '', '')
  return l:number
endfunction
