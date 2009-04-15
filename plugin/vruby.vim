"
"  vruby.vim  --  Interactive Ruby inside Vim
"

" (C) 2009 Bertram Scharpf <software@bertram-scharpf.de>
" License: BSD

" Put this file into some ~/.vim/plugin/ directory.


" Examples:
"
"   a = 'hello'
"   append a.upcase
"   ~
"   :%Ruby
"
"   23,45
"    5.01
"   ~
"   :%RubySum


function s:Ruby() range
  exec a:lastline
  put _
  ruby <<
    _ = eval(VIM.evaluate("getline(a:firstline,a:lastline)"))
    _.nil? or append "# => " + _.inspect
.
endfunc

function s:RubySum() range
  exec a:lastline
  ruby <<
    _ = eval(
      VIM.evaluate("getline(a:firstline,a:lastline)").map { |l|
        l.chomp!
        l.gsub! /(\d+),(\d+)/, "\\1.\\2"
        l
      }.join " + "
    )
    append "-"*32, _.inspect
.
endfunc

ruby <<
  def append *s
    s.any? or s.push nil
    c = VIM::Buffer.current
    s.each { |l|
      n = c.line_number
      c.append n, l.to_s.chomp
      n += 1
      Vim.command n.to_s
    }
    nil
  end
.

command -bar -nargs=0 -range=% Ruby    <line1>,<line2>call s:Ruby()
command -bar -nargs=0 -range=% RubySum <line1>,<line2>call s:RubySum()

