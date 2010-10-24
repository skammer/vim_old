" Convert from decimal to a named base.
function! ConvertToBase(int, base)

	if (a:base < 2 || a:base > 36)
		echohl ErrorMsg
		echo "Bad base - must be between 2 and 36."
		echohl None
		return ''
	endif

	if (a:int == 0)
		return 0
	endif

	let out=''

	let isnegative = 0
	let int=a:int
	if (int < 0)
		let isnegative = 1
		let int = - int
	endif

	while (int != 0)
		let out = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"[(int % a:base)] . out
		let int = int / a:base
	endwhile

	if isnegative
		let out = '-' . out
	endif

	return out
endfunction

" Convert from a named base to decimal.  Stop at any character that isn't a
" "base digit" (that is, an invalid character).
function! ConvertFromBase(str, base)

	let saveignorecase = &ignorecase
	let &ignorecase = 1

	if (a:base < 2 || a:base > 36)
		echohl ErrorMsg
		echo "Bad base - must be between 2 and 36."
		echohl None
		return ''
	endif

	if (a:str == '0')
		return 0
	endif

	let isnegative = 0
	let str = a:str
	if (str[0] == '-')
		let isnegative = 1
		let str = strpart(str,1,strlen(str))
	endif

	let out = 0
	let pos = 0
	let len = strlen(str)

	while (len > 0)
		let thisdigit = match("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", str[pos])

		if (thisdigit < 0 || thisdigit > a:base)
			break
		endif

		let i = 1
		let mult = 1
		while (i < len)
			let mult = a:base * mult
			let i = i + 1
		endwhile
		let len = len - 1
		let pos = pos + 1

		let thisdigit = thisdigit * mult
		let out = out + thisdigit
	endwhile

	let &ignorecase = saveignorecase

	if isnegative
		let out = '-' . out
	endif

	return out
endfunction

" Convert from a named base to a named base.
function! ConvertBases(str, base1, base2)
	let out = ConvertFromBase(a:str, a:base1)
	return ConvertToBase(out, a:base2)
endfunction

"function! ConvertBaseStr(str, base)
"	let out=''
"	let ix=0
"	while (ix < strlen(a:str))
"		let out = out . ConvertToBase(char2nr(a:str[ix]), a:base)
"		let ix = ix+1
"	endwhile
"	return out
"endfunction

"function! HexStr(str)
"	let out=''
"	let ix=0
"	while (ix < strlen(a:str))
"		let out = out . ConvertToBase(char2nr(a:str[ix]),16)
"		let ix = ix+1
"	endwhile
"	return out
"endfunction
