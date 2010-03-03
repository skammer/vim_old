" Vim syntax file
" Language:	todo
" Maintainer:	David O'Callaghan <david.ocallaghan@cs.tcd.ie>, Max Vasiliev
" URL:		http://www.cs.tcd.ie/David.OCallaghan/taskpaper.vim/
" Version:	1.1
" Last Change:  2009 Nov 21
" Filenames:    *.todo

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif

syn case ignore

syn match taskpaperProject       /^.\+:\s*$/
syn match taskpaperLineContinue ".$" contained
syn match taskpaperListItem  "-\+\s*.\+"
syn match taskpaperContext  "@\+\s*.\+"

"syn region todoTag  start=".*@" end=".\s*"
"syn match todoTag ".\+\(@.+\)"
"syn match  taskpaperContext  "@[A-Za-z0-9А-Яа-яёЁ_]\+"

"ryanb's bundle stuff
syn match todoResolved /x\+\s*.\+/
syn match todoOnHold "+\+\s*.\+"
syn match todoQuestionable "?\+\s*.\+"
syn match todoTooBig "%\+\s*.\+"
syn match todoUrgent "!\+\s*.\+"
"syn match todoKey  "[A-ZА-ЯЁё]\s*.\+"

syn region todoTag  start="\s\+@" end="\s\+"

"syn match todo
syn match taskpaperDone ".*@[Dd]one.*"
"syn match todoTag "\S\+\s\+\(@[A-ZА-ЯЁё_!?]*\)"


syn region taskpaperProjectFold start=/^.\+:\s*$/ end=/^\s*$/ transparent fold


syn sync fromstart

"highlighting for Taskpaper groups
HiLink taskpaperListItem Identifier
HiLink taskpaperContext  Identifier
"HiLink taskpaperContext  Todo
HiLink taskpaperProject  Title
HiLink taskpaperDone     NonText

"HiLink todoTag           Todo

"HiLink todoResolved      Include
HiLink todoResolved      NonText
HiLink todoOnHold        Comment
HiLink todoQuestionable  Statement
HiLink todoTooBig        Label
HiLink todoUrgent        Include
"HiLink todoKey           Ignore

let b:current_syntax = "todo"

delcommand HiLink

