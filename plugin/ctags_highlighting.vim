" ctags_highlighting
"   Author: A. S. Budden
"   Date:   22nd May 2009
"   Version: r259

if &cp || exists("g:loaded_ctags_highlighting")
	finish
endif
let g:loaded_ctags_highlighting = 1

if !exists('g:VIMFILESDIR')
	if has("unix")
		let g:VIMFILESDIR = $HOME . "/.vim/"
	endif

	if has("win32")
		let g:VIMFILESDIR = $VIM . "/vimfiles/"
	endif
endif

" These should only be included if editing a wx or qt file
" They should also be updated to include all functions etc, not just
" typedefs
let g:wxTypesFile = g:VIMFILESDIR . "types_wx.vim"
let g:qtTypesFile = g:VIMFILESDIR . "types_qt4.vim"
let g:wxPyTypesFile = g:VIMFILESDIR . "types_wxpy.vim"

" These should only be included if editing a wx or qt file
let g:wxTagsFile = g:VIMFILESDIR . 'tags_wx'
let g:qtTagsFile = g:VIMFILESDIR . 'tags_qt4'
let g:wxPyTagsFile = g:VIMFILESDIR . 'tags_wxpy'

" Update types & tags - called with a ! recurses
command! -bang -bar UpdateTypesFile silent call UpdateTypesFile(<bang>0, 0) | 
			\ let s:SavedTabNr = tabpagenr() |
			\ let s:SavedWinNr = winnr() |
			\ silent tabdo windo call ReadTypesAutoDetect() |
			\ silent exe 'tabn ' . s:SavedTabNr |
			\ silent exe s:SavedTabNr . "wincmd w"

command! -bang -bar UpdateTypesFileOnly silent call UpdateTypesFile(<bang>0, 1) | 
			\ let s:SavedTabNr = tabpagenr() |
			\ let s:SavedWinNr = winnr() |
			\ silent tabdo windo call ReadTypesAutoDetect() |
			\ silent exe 'tabn ' . s:SavedTabNr |
			\ silent exe s:SavedTabNr . "wincmd w"

" load the types_*.vim highlighting file, if it exists
autocmd BufRead,BufNewFile *.[ch]   call ReadTypes('c')
autocmd BufRead,BufNewFile *.[ch]pp call ReadTypes('c')
autocmd BufRead,BufNewFile *.p[lm]  call ReadTypes('pl')
autocmd BufRead,BufNewFile *.java   call ReadTypes('java')
autocmd BufRead,BufNewFile *.py     call ReadTypes('py')
autocmd BufRead,BufNewFile *.pyw    call ReadTypes('py')
autocmd BufRead,BufNewFile *.rb     call ReadTypes('ruby')
autocmd BufRead,BufNewFile *.vhd*   call ReadTypes('vhdl')

command! ReadTypes call ReadTypesAutoDetect()

function! ReadTypesAutoDetect()
	let extension = expand('%:e')
	let extensionLookup = 
				\ {
				\     '[ch]\(pp\)\?' : "c",
				\     'p[lm]'        : "pl",
				\     'java'         : "java",
				\     'pyw\?'        : "py",
				\     'rb'           : "ruby",
				\     'vhdl\?'       : "vhdl",
				\ }

	for key in keys(extensionLookup)
		let regex = '^' . key . '$'
		if extension =~ regex
			call ReadTypes(extensionLookup[key])
			"			echo 'Loading types for ' . extensionLookup[key] . ' files'
			continue
		endif
	endfor
endfunction

function! ReadTypes(suffix)
	let savedView = winsaveview()

	if exists('b:NoTypeParsing')
		return
	endif
	if exists('g:TypeParsingSkipList')
		let basename = expand('<afile>:p:t')
		let fullname = expand('<afile>:p')
		if index(g:TypeParsingSkipList, basename) != -1
			return
		endif
		if index(g:TypeParsingSkipList, fullname) != -1
			return
		endif
	endif
	let fname = expand('<afile>:p:h') . '/types_' . a:suffix . '.vim'
	if filereadable(fname)
		exe 'so ' . fname
	endif
	let fname = expand('<afile>:p:h:h') . '/types_' . a:suffix . '.vim'
	if filereadable(fname)
		exe 'so ' . fname
	endif
	let fname = 'types_' . a:suffix . '.vim'
	if filereadable(fname)
		exe 'so ' . fname
	endif

	" Open default source files
	if index(['cpp', 'h', 'hpp'], expand('<afile>:e')) != -1
		" This is a C++ source file
		call cursor(1,1)
		if search('^\s*#include\s\+<wx/', 'nc', 30)
			if filereadable(g:wxTypesFile)
				execute 'so ' . g:wxTypesFile
			endif
			execute 'setlocal tags+=' . g:wxTagsFile
		endif

		call cursor(1,1)
		if search('^\s*#include\s\+<q', 'nc', 30)
			if filereadable(g:qtTypesFile)
				execute 'so ' . g:qtTypesFile
			endif
			execute 'setlocal tags+=' . g:qtTagsFile
		endif
	elseif index(['py', 'pyw'], expand('<afile>:e')) != -1
		" This is a python source file

		call cursor(1,1)
		if search('^\s*import\s\+wx', 'nc', 30)
			if filereadable(g:wxPyTypesFile)
				execute 'so ' . g:wxPyTypesFile
			endif
			execute 'setlocal tags+=' . g:wxPyTagsFile
		endif
	endif
endfunction


func! UpdateTypesFile(recurse, skiptags)
	let s:vrc = globpath(&rtp, "mktypes.py")

	if type(s:vrc) == type("")
		let mktypes_py_file = s:vrc
	elseif type(s:vrc) == type([])
		let mktypes_py_file = s:vrc[0]
	endif

	let sysroot = 'python ' . mktypes_py_file
	let syscmd = ' --ctags-dir='

	if has("win32")
		let path = substitute($PATH, ';', ',', 'g')
		let ctags_exe_list = split(globpath(path, 'ctags.exe'))
		if len(ctags_exe_list) > 0
			let ctags_exe = ctags_exe_list[0]
		else
			let ctags_exe = ''
		endif

		" If ctags is not in the path, look for it in vimfiles/
		if !filereadable(ctags_exe)
			let ctags_exe = split(globpath(&rtp, "ctags.exe"))[0]
		endif

		if filereadable(ctags_exe)
			let ctags_path = escape(fnamemodify(ctags_exe, ':p:h'),' \')
		else
			throw "Cannot find ctags"
		endif
	else
		let path = substitute($PATH, ':', ',', 'g')
		if has("win32unix")
			let ctags_exe = split(globpath(path, 'ctags.exe'))[0]
		else
			let ctags_exe = split(globpath(path, 'ctags'))[0]
		endif
		if filereadable(ctags_exe)
			let ctags_path = fnamemodify(ctags_exe, ':p:h')
		else
			throw "Cannot find ctags"
		endif
	endif

	let syscmd .= ctags_path
	
	if exists('b:TypesFileRecurse')
		if b:TypesFileRecurse == 1
			let syscmd .= ' -r'
		endif
	else
		if a:recurse == 1
			let syscmd .= ' -r'
		endif
	endif

	if exists('b:TypesFileLanguages')
		for lang in b:TypesFileLanguages
			let syscmd .= ' --include-language=' . lang
		endfor
	endif

	if exists('b:TypesFileSkipSynMatches')
		if b:TypesFileSkipSynMatches == 1
			let syscmd .= ' --skip-matches'
		endif
	endif

	if exists('b:TypesFileIncludeLocals')
		if b:TypesFileIncludeLocals == 1
			let syscmd .= ' --include-locals'
		endif
	endif

	if exists('b:TypesFileDoNotGenerateTags')
		if b:TypesFileDoNotGenerateTags == 1
			let syscmd .= ' --use-existing-tagfile'
		endif
	elseif a:skiptags == 1
		let syscmd .= ' --use-existing-tagfile'
	endif

	let syscmd .= ' --check-keywords --analyse-constants'

	if exists('g:CheckForCScopeFiles')
		let syscmd .= ' --build-cscopedb-if-filelist'
		let syscmd .= ' --cscope-dir=' 
		if has("win32")
			let path = substitute($PATH, ';', ',', 'g')
			let cscope_exe_list = split(globpath(path, 'cscope.exe'))
			if len(cscope_exe_list) > 0
				let cscope_exe = cscope_exe_list[0]
			else
				let cscope_exe = ''
			endif

			" If cscope is not in the path, look for it in
			" vimfiles/extra_source/cscope_win
			if !filereadable(cscope_exe)
				let cscope_exe = split(globpath(&rtp, "extra_source/cscope_win/cscope.exe"))[0]
			endif

			if filereadable(cscope_exe)
				let cscope_path = escape(fnamemodify(cscope_exe, ':p:h'),' \')
			else
				throw "Cannot find cscope"
			endif
		else
			let path = substitute($PATH, ':', ',', 'g')
			if has("win32unix")
				let cscope_exe = split(globpath(path, 'cscope.exe'))[0]
			else
				let cscope_exe = split(globpath(path, 'cscope'))[0]
			endif
			if filereadable(cscope_exe)
				let cscope_path = fnamemodify(cscope_exe, ':p:h')
			else
				throw "Cannot find cscope"
			endif
		endif
		let syscmd .= cscope_path
	endif

	let sysoutput = system(sysroot . syscmd) 
	echo sysroot . syscmd
	if sysoutput =~ 'python.*is not recognized as an internal or external command'
		let sysroot = g:VIMFILESDIR . 'extra_source/mktypes/dist/mktypes.exe'
		let sysoutput = sysoutput . "\nUsing compiled mktypes\n" . system(sysroot . syscmd)
	endif

	echo sysoutput



	" There should be a try catch endtry
	" above, with the fall-back using the
	" exe on windows or the full system('python') etc
	" on Linux

endfunc

