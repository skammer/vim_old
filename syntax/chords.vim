" Vim syntax file
" Language:     (Guitar) chords and tabs
" Maintainer:   Roman Cheplyaka <roma@ro-che.info>
" Last Change:  2007 Dec 30
" NOTE:
" The following variables control syntax hiliting:
"
"   b:chords_enable
" Enable hiliting of chords (like A or F#7)
"
"   b:tabs_enable
" Enable hiliting of tabs. Example:
" |------7---2----3-4--|
"
"   b:chords_linewise
" If this variable is true, only line of chords recognized. If there's
" something in line which does not look like chords, no hiliting is performed.
" This is useful for songs in English (and other languages which use Latin
" charset), to prevent recognizing e.g. article "A" as chord.
" If you mostly deal with e.g. Russian songs you might want to disable this.
" In that case everything looking like chords will be hilited.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if ! exists("b:chords_enable")
	let b:chords_enable = 1
endif
if ! exists("b:tabs_enable")
	let b:tabs_enable = 1
endif
if ! exists("b:chords_linewise")
	let b:chords_linewise = 1
endif

syntax clear
syntax case match
set iskeyword+=#

let s:suffix_regexp = "[+b\\#m[:digit:]]|maj|sus"
let  s:chord_regexp = "<[A-H](" . s:suffix_regexp . ")*>"
let    s:tab_regexp = "^.*\\|.*$"

if b:chords_enable
	if b:chords_linewise
		execute "syntax match chord /\\v^\\s*(". s:chord_regexp ."\\s*)+$/"
	else
		execute "syntax match chord /\\v". s:chord_regexp ."/"
	endif
	highlight link chord keyword
endif
if b:tabs_enable
	execute "syntax match tab_line /\\v". s:tab_regexp ."/ contains=tab"
	syntax match tab /\v\|.*\|/ contained contains=tab_elem,tab_delim
	syntax match tab_elem /[^-|]/ contained
	syntax match tab_delim /|/ contained
	highlight link tab_line comment
	highlight link tab comment
	highlight link tab_elem string
	highlight link tab_delim special
endif

